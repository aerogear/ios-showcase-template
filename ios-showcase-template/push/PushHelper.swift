import AGSCore
import AGSPush
import Foundation
import UIKit
import UserNotifications

/**
* Contains set of methods used to handle push configuration and messaging.
*/
public class PushHelper {
    
    
    
    /**
      Called when push message was received.
      Presents dialog with message
    */
    public func onPushMessageReceived(_ userInfo: [AnyHashable: Any], _ fetchCompletionHandler: (UIBackgroundFetchResult) -> Void) {
        AgsCore.logger.info("Push message received: \(userInfo)")
        
        var pushNotificationInfo = [AnyHashable: Any]()
        pushNotificationInfo["user_info"] = userInfo
        pushNotificationInfo["received_at"] = Date()
        
        // When a message is received, send Notification, would be handled by registered ViewController
        let notification: Notification = Notification(name: Notification.Name(rawValue: "message_received"), object: nil, userInfo: pushNotificationInfo)
        NotificationCenter.default.post(notification)

        // No additioanl data to fetch
        fetchCompletionHandler(UIBackgroundFetchResult.noData)
    }

    /**
     Initial setup for push notifications

     - registration for remote configuration
     - granting permissions from users
    */
    public func setupPush() {
        UIApplication.shared.registerForRemoteNotifications()
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) {
                granted, error in
                if granted {
                    print("Approval granted to send notifications")
                } else {
                    print(error ?? "")
                }
            }
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
    }
}
