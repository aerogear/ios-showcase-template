//
//  MenuUIViewController.swift
//  ios-showcase-template
//
//  Created by Wei Li on 03/11/2017.
//

import UIKit

protocol DrawerMenuDelegate {
    func drawerMenuItemSelectedAtIndex(_ index: Int, _ animated: Bool)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    /** Menu options */
    @IBOutlet var tblMenuOptions: UITableView!

    /** Transparent button to hide menus */
    @IBOutlet var btnCloseDrawerOverlay: UIButton!

    /** Array containing the menu items */
    var arrayMenuOptions = [MenuItem]()

    /** Menu button which was tapped to display the menu */
    var btnMenu: UIButton!

    /** Delegate of the MenuVC */
    var delegate: DrawerMenuDelegate?
    
    var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)

    /** If the menu is visible. Read-only **/
    private(set) var isOpen: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuOptions.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()
    }

    func updateArrayMenuOptions() {
        tblMenuOptions.reloadData()
    }

    @IBAction func onCloseMenuClick(_ button: UIButton!) {
        btnMenu.tag = 0

        if self.delegate != nil {
            var index = Int(button.tag)
            if button == self.btnCloseDrawerOverlay {
                index = -1
            }
            delegate?.drawerMenuItemSelectedAtIndex(index, true)
        }

        self.disappearWithAnimation()
    }

    func setMenuItems(_ items: [MenuItem]) {
        self.arrayMenuOptions = items
    }

    func appearWithAnimation() {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.btnMenu.isEnabled = true
            self.isOpen = true
        }, completion: nil)
    }

    func disappearWithAnimation() {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
            self.isOpen = false
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        })
    }

    func resizeView() {
        self.view.frame = CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    }

    /*
    // MARK: - UITableViewDataSource protocol
    */

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        let imageViewTag = 1
        let titleViewTag = 2

        
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        if self.selectedIndexPath == indexPath {
            cell.backgroundColor = UIColor.init(named: "Lightgrey")!
        }

        let lblTitle: UILabel = cell.contentView.viewWithTag(titleViewTag) as! UILabel
        let imgIcon: UIImageView = cell.contentView.viewWithTag(imageViewTag) as! UIImageView

        imgIcon.image = nil
        lblTitle.text = nil
        lblTitle.text = arrayMenuOptions[indexPath.row].title
        var textColor = UIColor.black
        if self.selectedIndexPath == indexPath {
            textColor = UIColor.init(named: "Orange")!
        }
        let currentFontSize = lblTitle.font.pointSize
        
        lblTitle.textColor = textColor
        lblTitle.font = UIFont.systemFont(ofSize: currentFontSize)
        if let menuItemIcon = arrayMenuOptions[indexPath.row].iconName {
            let iconImage = UIImage(named: menuItemIcon)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            var imageColor = UIColor.black
            if self.selectedIndexPath == indexPath {
                imageColor = UIColor.init(named: "Orange")!
            }
            imgIcon.image = iconImage
            imgIcon.tintColor = imageColor
            let currentFontSize = lblTitle.font.pointSize
            lblTitle.font = UIFont.boldSystemFont(ofSize: currentFontSize)
        } else {
            //no icon, it is submenu item
            lblTitle.font = lblTitle.font.withSize(14)
            var layouMargin = cell.layoutMargins
            layouMargin.left = 20
            cell.layoutMargins = layouMargin
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*
     // MARK: - UITableViewDelegate protocol
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(btn)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
