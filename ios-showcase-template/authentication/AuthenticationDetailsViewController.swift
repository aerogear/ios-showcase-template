//
//  AuthenticationDetailsViewController.swift
//  ios-showcase-template
//
//  Created by Wei Li on 20/11/2017.
//

import AGSAuth
import UIKit

class AuthenticationDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet var userInfoView: UITableView!
    @IBOutlet weak var userRolesView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    
    var currentUser: User? {
        didSet {
            if let tableView = self.userInfoView, let rolesView = self.userRolesView {
                tableView.reloadData()
                rolesView.reloadData()
            }
        }
    }

    var navbarItem: UINavigationItem?
    var authListener: AuthListener?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userInfoView.dataSource = self
        userInfoView.delegate = self
        userRolesView.dataSource = self
        userRolesView.delegate = self
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
        //ViewHelper.showSuccessBannerMessage(from: self, title: "Login Completed", message: "")
    }

    func showError(title: String, error: Error) {
        ViewHelper.showErrorBannerMessage(from: self, title: title, message: error.localizedDescription)
    }

    func removeView() {
        ViewHelper.removeViewController(viewController: self)
    }

    func showLogoutBtn() {
        self.logoutButton.isHidden = false
    }

    func removeLogoutBtn() {
        self.logoutButton.isHidden = true
    }

    @IBAction func logoutTapped(_ sender: Any) {
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.userInfoView {
            var cell: UITableViewCell
            //not great. There should be a better way to do this...
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "fullnameCell")!
                let profileImage = UIImage(named: "ic_person")?.withRenderingMode(.alwaysTemplate)
                let userProfileImageView = cell.contentView.viewWithTag(3) as! UIImageView
                userProfileImageView.image = profileImage
                userProfileImageView.tintColor = UIColor(named: "Primary")!
                let fullNameLabel = cell.contentView.viewWithTag(2) as! UILabel
                fullNameLabel.text = self.currentUser!.fullName
            case 1:
                cell = tableView.dequeueReusableCell(withIdentifier: "emailCell")!
                let emailLabel = cell.contentView.viewWithTag(2) as! UILabel
                emailLabel.text = self.currentUser!.email
            case 2:
                cell = tableView.dequeueReusableCell(withIdentifier: "usernameCell")!
                let usernameLabel = cell.contentView.viewWithTag(2) as! UILabel
                usernameLabel.text = self.currentUser!.userName
            case 3:
                cell = tableView.dequeueReusableCell(withIdentifier: "otpEnabledCell")!
                //hard coded for now, need to fix this in the future once the info is available from the auth sdk
                let closeImage = UIImage(named: "ic_close")?.withRenderingMode(.alwaysTemplate)
                let enabledImageView = cell.contentView.viewWithTag(1) as! UIImageView
                enabledImageView.image = closeImage
                enabledImageView.tintColor = UIColor(named: "Red")!
            case 4:
                cell = tableView.dequeueReusableCell(withIdentifier: "emailVerifiedCell")!
                //hard coded for now, need to fix this in the future once the info is available from the auth sdk
                let closeImage = UIImage(named: "ic_close")?.withRenderingMode(.alwaysTemplate)
                let enabledImageView = cell.contentView.viewWithTag(1) as! UIImageView
                enabledImageView.image = closeImage
                enabledImageView.tintColor = UIColor(named: "Red")!
            default:
                cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            }
            return cell
        }
        
        if tableView == self.userRolesView {
            var cell: UITableViewCell
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "headerCell")!
            default:
                cell = tableView.dequeueReusableCell(withIdentifier: "roleNameCell", for: indexPath)
                let roleValueLabel = cell.contentView.viewWithTag(1) as! UILabel
                roleValueLabel.text = self.currentUser!.realmRoles[indexPath.row - 1]
            }
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.userInfoView {
            return 5
        }
        
        if tableView == self.userRolesView {
            print("\(self.currentUser!.realmRoles.count)")
            return self.currentUser!.realmRoles.count + 1
        }
        
        return 0
    }
}
