//
//  AppDelegate.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import IQKeyboardManager
import GoogleMaps
import GooglePlaces
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import NotificationBannerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
    let googleApiKey = "AIzaSyBtEyE10T9uHR79PMTPMTNZCGrWiYakBx0"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let user = DataManager.shared.getUser()
        GMSServices.provideAPIKey(googleApiKey)
        GMSPlacesClient.provideAPIKey(googleApiKey)
        
        if user != nil {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController")
            //let navigationController = UINavigationController(rootViewController: vc)
            self.window?.rootViewController = vc
        }
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().tintColor = UIColor.init(netHex: Colors.purple)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.darkGray]
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        
        IQKeyboardManager.shared().isEnabled = true
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
            Messaging.messaging().remoteMessageDelegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        FirebaseApp.configure()
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("NTO: \(userInfo)")
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("NTO local \(notification.alertTitle) \(notification.alertBody)")
    }

}
extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("NTO token \(fcmToken)")
    }
    
    // The callback to handle data message received via FCM for devices running iOS 10 or above.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("NTO \(messaging.description)")
        
        print("NTO \(remoteMessage.appData)")
    }
    
    func application(received remoteMessage: MessagingRemoteMessage) {
        
        print("NTO \(remoteMessage)")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        guard let userInfo = userInfo as NSDictionary? as? [String: Any] else {return}
        let name_of_message = userInfo["google.c.a.c_l"]!
        let body_of_message = userInfo["aps"] as! NSDictionary? as? [String: Any]
        let body_alert = body_of_message!["alert"]!
        let banner = NotificationBanner(title: name_of_message as! String, subtitle: body_alert as! String, style: .info)
        banner.backgroundColor = UIColor.init(netHex: Colors.purple)
        banner.autoDismiss = false
        banner.haptic = .light
        banner.show(queuePosition: .front)
        banner.dismissOnTap = true
        banner.dismissOnSwipeUp = true
        let uuid = UUID().uuidString
        print(uuid)
        print("NTO name - \(name_of_message) body - \(body_alert)")
    }
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("NTO \(response.notification)")
    }
}

