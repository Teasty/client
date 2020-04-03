//
//  AppDelegate.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 12/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

//  shopapp-5dj48@ageone.ru     |       2Q4hK4AvcT
//  https://bill2fast.com/login |       shopapp-5dj48@ageone.ru     |       8veDD8MeZ48xh8aG
//  https://smsc.ru             |       shopapp-5dj48@ageone.ru     |       8veDD8MeZ48xh8aG

import UIKit
import SwiftyBeaver
import PromiseKit
import SnapKit
import Rswift
import SwiftHEXColors
import Kingfisher
import GoogleMaps
import GooglePlaces
import RealmSwift
import Firebase
import UserNotifications

// MARK: Created Globaly

let log = SwiftyBeaver.self
let coordinator = FlowCoordinator()
let router = Router()
let api = API()
let database = DataBase.self
let user = UserData()
let locationManager = LocationManager()
let reachability = Reachability()!
let alertAction = AlertAction()
let utils = Utiles()
let loading = LoadingUILocker()
let rxData = RxData()
let socket = SocketIONetwork()

// MARK: AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let gcmMessageIDKey = "gsm.message_id"
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        user.info.isNeedToShowOnWayAlert = true
        user.info.isNeedToShowRateOrderView = true
        user.info.paymentType = "cash"
        user.info.didAskForDiscount = false
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        InstanceID.instanceID().instanceID { (result, error) in
          if let error = error {
            log.error("Error fetching remote instance ID: \(error)")
          } else if let result = result {
            log.info("Remote instance ID token: \(result.token)")
            user.tokenFCM = result.token
          }
        }
        
        // Override point for customization after application launch.
        
        // MARK: Kingfisher cache time settings
        
        //        ImageCache.default.memoryStorage.config.expiration = .never
        //        ImageCache.default.diskStorage.config.expiration = .never
        
        // MARK: Google
        
        GMSServices.provideAPIKey(utils.keys.googleApiKey)
        GMSPlacesClient.provideAPIKey(utils.keys.googleApiKey)
        
        // MARK: logger console mode
        
        log.addDestination(ConsoleDestination())
        
        // MARK: Run Coordinator
        
        coordinator.setLaunchScreen()
        firstly {
            api.handshake()
        }.done { _ in
            api.getFCMToken()
        }.done { _ in
            coordinator.start()
        }.catch { (error) in
            log.error("\(error)")
        }
        
        // MARK: Reachability
        
        reachability.whenReachable = { _ in
            log.debug("is reachable")
        }
        reachability.whenUnreachable = { _ in
            log.debug("is unreachable")
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        // MARK: Reachability
        
        reachability.stopNotifier()
        log.debug("reachability stop")
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        // MARK: Reachability
        
        do {
            try reachability.startNotifier()
            log.debug("reachability start")
        } catch {
            log.debug("reachability error")
        }
        
        
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        user.tokenFCM = fcmToken
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        log.debug("Message: \(remoteMessage.appData)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            log.debug("Message ID: \(messageID)")
        }
        
        // Print full message.
        log.debug(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            log.debug("Message ID: \(messageID)")
        }
        
        // Print full message.
        log.debug(userInfo)
        
        completionHandler()
    }
}
