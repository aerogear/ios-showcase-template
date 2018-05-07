import AGSAuth
import AGSPush
import UIKit
import UserNotifications
import CoreData

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
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "secure_ios_app")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
