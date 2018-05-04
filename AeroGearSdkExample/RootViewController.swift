import UIKit

class RootViewController: BaseViewController, DrawerMenuDelegate {
    // swiftlint:disable identifier_name
    static let MENU_HOME_TITLE = "Home"
    // swiftlint:disable identifier_name
    static let MENU_AUTHENTICATION_TITLE = "Authentication"
    // swiftlint:disable identifier_name
    static let MENU_ACCESS_CONTROL_TITLE = "Access Control"
    // swiftlint:disable identifier_name
    static let MENU_PUSH_TITLE = "Push"
    // swiftlint:disable identifier_name
    static let MENU_DEVICE_TRUST_TITLE = "Device Trust"

    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        menuDelegate = self
        // Do any additional setup after loading the view.
        addMenuItem(titleOfChildView: RootViewController.MENU_HOME_TITLE, iconName: "ic_home")
        addMenuItem(titleOfChildView: RootViewController.MENU_AUTHENTICATION_TITLE, iconName: "ic_account_circle")
        addMenuItem(titleOfChildView: RootViewController.MENU_ACCESS_CONTROL_TITLE, iconName: "ic_verified_user")
        addMenuItem(titleOfChildView: RootViewController.MENU_PUSH_TITLE, iconName: "ic_notification")
        addMenuItem(titleOfChildView: RootViewController.MENU_DEVICE_TRUST_TITLE, iconName: "ic_device_trust")
        showFirstChild()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func drawerMenuItemSelectedAtIndex(_ index: Int, _: Bool) {
        if index >= 0 {
            let selectedMenuItem = arrayMenuOptions[index]
            switch selectedMenuItem.title {
            case RootViewController.MENU_HOME_TITLE:
                launchHomeView()
            case RootViewController.MENU_AUTHENTICATION_TITLE:
                launchAuthView()
            case RootViewController.MENU_ACCESS_CONTROL_TITLE:
                launchAccessControlView()
            case RootViewController.MENU_PUSH_TITLE:
                launchPushView()
            case RootViewController.MENU_DEVICE_TRUST_TITLE:
                launchDeviceTrustView()
            default:
                print("no view to show")
            }
        }
    }

    func launchHomeView() {
        let homeViewController = HomeViewController.loadViewController()
        presentViewController(homeViewController)
    }

    func launchAuthView() {
        let authViewController = AuthViewController.loadViewController()
        presentViewController(authViewController)
    }
    
    func launchAccessControlView() {
        let accessControlViewController = AccessControlViewController.loadViewController()
        presentViewController(accessControlViewController)
    }

    func launchPushView() {
        let pushViewController = PushViewController.loadViewController()
        presentViewController(pushViewController)
    }
    
    func launchDeviceTrustView() {
        let deviceTrustViewController = DeviceTrustViewController.loadViewController()
        presentViewController(deviceTrustViewController)
    }
}
