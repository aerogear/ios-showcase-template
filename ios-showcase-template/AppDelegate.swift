//
//  AppDelegate.swift
//  secure-ios-app
//
//  Created by Wei Li on 03/11/2017.
//  Copyright © 2017 Wei Li. All rights reserved.
//

import UIKit
import CoreData
import TrustKit
import AGSAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var authService: AgsAuth?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // tag::trustkitConfig[]
        // Define TrustKit configuration
        let trustKitConfig = [
            kTSKSwizzleNetworkDelegates: true,
            kTSKPinnedDomains: [
                "security.feedhenry.org": [
                    kTSKIncludeSubdomains : true,
                    kTSKEnforcePinning : true,
                    kTSKPublicKeyAlgorithms: [kTSKAlgorithmRsa2048],
                    kTSKPublicKeyHashes: [
                        "trENjoQnbWupnAtu1/WagBE0RgJ+p7ke2ppWML8vAl0=",
                        "arENjoQnbWupnAtu1/WagBE0RgJ+p7ke2ppWML8vAl0="
                    ],]]] as [String : Any]
        
        // Init TrustKit with the above config
        TrustKit.initSharedInstance(withConfiguration: trustKitConfig)
        // end::trustkitConfig[]
        
        //Load the configuration file
        let configFilePath = Bundle.main.path(forResource: "AppConfig", ofType: "plist")!
        let configDict = NSDictionary(contentsOfFile: configFilePath)!
        let appConfiguration = AppConfiguration(configDict)
        
        let appComponents = AppComponents(appConfiguration: appConfiguration)
        
        let rootBuilder = RootBuilder(components: appComponents)
        let rootRouter = rootBuilder.build()
        rootRouter.launchFromWindow(window: window!)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        do {
            return try authService!.resumeAuth(url: url as URL)
        } catch AgsAuth.Errors.serviceNotConfigured {
            print("Aerogear auth service is not configured")
        } catch {
            fatalError("Unexpected error: \(error)")
        }
        return false
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

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
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

