//
//  AuthenticationDetailsViewController.swift
//  secure-ios-app
//
//  Created by Wei Li on 20/11/2017.
//  Copyright © 2017 Wei Li. All rights reserved.
//

import UIKit
import AGSAuth


class AuthenticationDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var userInfoView: UITableView!
    
    var currentUser: User? {
        didSet {
            if let tableView = self.userInfoView {
                tableView.reloadData()
            }
        }
    }
    
    var navbarItem: UINavigationItem?
    var authListener: AuthListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userInfoView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showLogoutBtn()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.removeLogoutBtn()
    }
    
    func displayUserDetails(from: UIViewController, user: User) {
        self.currentUser = user
        ViewHelper.showChildViewController(parentViewController: from, childViewController: self)
        ViewHelper.showSuccessBannerMessage(from: self, title: "Login Completed", message: "")
    }
    
    func showError(title: String, error: Error) {
        ViewHelper.showErrorBannerMessage(from: self, title: title, message: error.localizedDescription)
    }
    
    func removeView() {
        ViewHelper.removeViewController(viewController: self)
    }
    
    func showLogoutBtn() {
        guard  let rootViewController = self.parent?.parent else {
            return
        }
        if rootViewController.isKind(of: RootViewController.self) {
            self.navbarItem = rootViewController.navigationItem
            self.navbarItem!.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        }
    }
    
    func removeLogoutBtn() {
        if self.navbarItem != nil {
            self.navbarItem!.rightBarButtonItem = nil;
        }
    }
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        let alertView = UIAlertController(title: "Logout", message: "Are you sure to logout?", preferredStyle: UIAlertControllerStyle.alert)
        alertView.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            if let listener = self.authListener {
                listener.logout()
            }
        }))
        alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            Logger.debug("logout cancelled")
        }))
        self.present(alertView, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return self.currentUser!.realmRoles.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionNum = indexPath.section
        if (sectionNum == 0) {
            let userInfoCell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell")!
            let fieldNameLabel = userInfoCell.contentView.viewWithTag(1) as! UILabel
            let fieldValueLabel = userInfoCell.contentView.viewWithTag(2) as! UILabel
            if (indexPath.row == 0) {
                fieldNameLabel.text = "Name"
                fieldValueLabel.text = self.currentUser!.fullName
            } else {
                fieldNameLabel.text = "Email"
                fieldValueLabel.text = self.currentUser!.email
            }
            return userInfoCell
        } else {
            let roleNameCell = tableView.dequeueReusableCell(withIdentifier: "roleNameCell")!
            let roleValueLabel = roleNameCell.contentView.viewWithTag(1) as! UILabel
            roleValueLabel.text = self.currentUser!.realmRoles[indexPath.row]
            return roleNameCell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "User Details"
        case 1:
            return "Realm Roles"
        default:
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
}
