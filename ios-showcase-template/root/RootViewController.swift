//
//  RootViewController.swift
//  ios-showcase-template
//
//  Created by Wei Li on 06/11/2017.
//

import UIKit

struct MenuItem {
    var type: MenuItemType
    var title: String
    var iconName: String?
    
    init(_ type: MenuItemType, _ title: String, _ iconName: String?) {
        self.type = type
        self.title = title
        self.iconName = iconName
    }
}

enum MenuItemType {
    case home
    case identityManagement
    case identityManagementDocs
    case identityManagementAuth
    case identityManagementSSO
    case deviceSec
    case deviceSecDocs
    case deviceSecTrust
    case deviceSecStorage
    case deviceSecPinning
    case push
    case pushDocs
    case pushMessage
    case metrics
    case metricsDocs
    case metricsProfile
    case metricsTrust
}

/*
 The main root view controller. It is responsible for listening to the user interaction events, and passing the events on to the listener (interactor).
 */
class RootViewController: BaseViewController, DrawerMenuDelegate {
    
    static let MENU_ITEM_TITLE_HOME = "Home"
    
    static let MENU_ITEM_TITLE_IDM = "Identity Management"
    static let MENU_ITEM_TITLE_IDM_DOCS = "Documentation"
    static let MENU_ITEM_TITLE_IDM_AUTH = "Authentication"
    static let MENU_ITEM_TITLE_IDM_SSO = "SSO"
    
    static let MENU_ITEM_TITLE_SEC = "Device Security"
    static let MENU_ITEM_TITLE_SEC_DOCS = "Documentation"
    static let MENU_ITEM_TITLE_SEC_TRUST = "Device Trust"
    static let MENU_ITEM_TITLE_SEC_STORAGE = "Secure Storage"
    static let MENU_ITEM_TITLE_SEC_PINNING = "Cert Pinning"
    
    static let MENU_ITEM_TITLE_PUSH = "Push Notifications"
    static let MENU_ITEM_TITLE_PUSH_DOCS = "Documentation"
    static let MENU_ITEM_TITLE_PUSH_MESSAGE = "Push Messages"
    
    static let MENU_ITEM_TITLE_METRICS = "Metrics"
    static let MENU_ITEM_TITLE_METRICS_DOCS = "Documentation"
    static let MENU_ITEM_TITLE_METRICS_PROFILE = "Device Profile Info"
    static let MENU_ITEM_TITLE_METRICS_TRUST = "Trust Check Info"
    
    static let SUBMENU_ITEM_TITLE_IDM_AUTH_DETAILS = "Identity Profile"
    
    static let MENU_ITEMS = [
        MenuItem(MenuItemType.home, MENU_ITEM_TITLE_HOME, "ic_home"),
        
        MenuItem(MenuItemType.identityManagement, MENU_ITEM_TITLE_IDM, "ic_account_circle"),
        MenuItem(MenuItemType.identityManagementDocs, MENU_ITEM_TITLE_IDM_DOCS, nil),
        MenuItem(MenuItemType.identityManagementAuth, MENU_ITEM_TITLE_IDM_AUTH, nil),
        MenuItem(MenuItemType.identityManagementSSO, MENU_ITEM_TITLE_IDM_SSO, nil),
        
        MenuItem(MenuItemType.deviceSec, MENU_ITEM_TITLE_SEC, "ic_security"),
        MenuItem(MenuItemType.deviceSecDocs, MENU_ITEM_TITLE_SEC_DOCS, nil),
        MenuItem(MenuItemType.deviceSecTrust, MENU_ITEM_TITLE_SEC_TRUST, nil),
        MenuItem(MenuItemType.deviceSecStorage, MENU_ITEM_TITLE_SEC_STORAGE, nil),
        MenuItem(MenuItemType.deviceSecPinning, MENU_ITEM_TITLE_SEC_PINNING, nil),
        
        MenuItem(MenuItemType.push, MENU_ITEM_TITLE_PUSH, "ic_notification_active"),
        MenuItem(MenuItemType.pushDocs, MENU_ITEM_TITLE_PUSH_DOCS, nil),
        MenuItem(MenuItemType.pushMessage, MENU_ITEM_TITLE_PUSH_MESSAGE,nil),
        
        MenuItem(MenuItemType.metrics, MENU_ITEM_TITLE_METRICS, "ic_metrics"),
        // NOTE: These should be added back in when the metrics pages are created
        MenuItem(MenuItemType.metricsDocs, MENU_ITEM_TITLE_METRICS_DOCS, nil),
        MenuItem(MenuItemType.metricsProfile, MENU_ITEM_TITLE_METRICS_PROFILE, nil),
        MenuItem(MenuItemType.metricsTrust, MENU_ITEM_TITLE_METRICS_TRUST, nil)
    ]


    var listener: MenuListener?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuDelegate = self

        for menuItem in RootViewController.MENU_ITEMS {
            addMenuItem(menuItem)
        }
        
        showFirstChild()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //listen for the menu item selected event, and invoke the listener
    func drawerMenuItemSelectedAtIndex(_ index: Int, _ animated: Bool = true) {
        if index >= 0 {
            let selectedMenuItem = arrayMenuOptions[index]
            listener?.onMenuItemSelected(selectedMenuItem)
        }
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
