import AGSAuth
import AGSPush
import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var pushHelper = PushHelper()

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        do {
            return try AgsAuth.instance.resumeAuth(url: url as URL)
        } catch AgsAuth.Errors.serviceNotConfigured {
            print("AeroGear auth service is not configured")
        } catch {
            fatalError("Unexpected error: \(error).")
        }
        return false
    }

    func applicationWillResignActive(_: UIApplication) {
    }
    
    /**
     - Function to show a blurred image instead for the app preview when the app is sent to the background. This will prevent the iOS snapshot caching vulnerability.
     */
    func applicationDidEnterBackground(_ application: UIApplication) {
        let imageView = UIImageView(frame: (self.window?.bounds)!)
        imageView.tag = 99
        imageView.image = UIImage(named: "snapshot_cache_protection")
        UIApplication.shared.keyWindow?.subviews.last?.addSubview(imageView)
    }
    
    /**
     - Function to remove the blurred image on app resume.
     */
    func applicationWillEnterForeground(_ application: UIApplication) {
        let imageView = UIApplication.shared.keyWindow?.subviews.last?.viewWithTag(99) as!
        UIImageView
        imageView.removeFromSuperview()
    }

    func applicationDidBecomeActive(_: UIApplication) {
    }

    func applicationWillTerminate(_: UIApplication) {
    }

    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        pushHelper.setupPush()
        let authenticationConfig = AuthenticationConfig(redirectURL: "org.aerogear.mobile.example:/callback")
        try! AgsAuth.instance.configure(authConfig: authenticationConfig)
        return true
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        pushHelper.registerUPS(deviceToken)
    }

    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        pushHelper.onRegistrationFailed(error)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        pushHelper.onPushMessageReceived(userInfo, fetchCompletionHandler)
    }
}
