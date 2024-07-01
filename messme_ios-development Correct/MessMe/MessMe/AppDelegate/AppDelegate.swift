//
//  AppDelegate.swift
//  MessMe
//
//  Created by Prashant Sharma on 17/05/22.
//

let SharedAppDelegate = UIApplication.shared.delegate as! AppDelegate // no need in this prj.

import Firebase
import FirebaseMessaging
import UserNotifications
import UIKit
import IQKeyboardManagerSwift
import Braintree
import LanguageManager_iOS


let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
let Storyboard = UIStoryboard(name: "Main", bundle: nil)
let userDefault = UserDefaults.standard

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var localString = String()
    let gcmMessageIDKey = "gcm.MessageID_Key"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in guard success
//        else { return }
//        print("Success in APNS Request") }
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
            
          // UNUserNotificationCenter.current().delegate = self
          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }
        
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
              DataManager.tokenId = token
//            self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
          }
        }
        
        application.registerForRemoteNotifications()
        
        BTAppContextSwitcher.setReturnURLScheme("com.your-company.your-app.payments")
                
        let selectedLanguage: Languages = DataManager.Language == "fr" ? .fr : .en
        LanguageManager.shared.defaultLanguage = selectedLanguage
        
        
        if DataManager.isLogin == true {
            let initialViewController = Storyboard.instantiateViewController(withIdentifier: "MyAccountViewController") as! MyAccountViewController
            (self.window?.rootViewController as! UINavigationController).pushViewController(initialViewController, animated: false)
        }
        
//        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.tokenRefereshNotification), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)

        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done".localiz()
        
        sleep(2)
        return true
    }
    
    func application(_ application: UIApplication,
                         didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            Messaging.messaging().apnsToken = deviceToken
        }

//        @objc func tokenRefereshNotification()
//        {
//            let refereshtoken  = InstanceID.instanceID().token() ?? ""
//
//            print("token23123::::\(refereshtoken)")
//            UserDefaults.standard.set(refereshtoken, forKey: "deviceToken")
//            connectToFCM()
//        }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult)
                       -> Void) {
      if let messageID = userInfo[gcmMessageIDKey] {
          
        print("Message ID: \(messageID)")
      }
        
      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme?.localizedCaseInsensitiveCompare("com.your-company.your-app.payments") == .orderedSame {
            return BTAppContextSwitcher.handleOpenURL(url)
        }
        return false
    }
    
}


extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler:
    @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler([[.banner, .sound]])
  }

  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    completionHandler()
  }
}

extension AppDelegate: MessagingDelegate {
  func messaging(
    _ messaging: Messaging,
    didReceiveRegistrationToken fcmToken: String?
  ) {
    let tokenDict = ["token": fcmToken ?? ""]
    NotificationCenter.default.post(
      name: Notification.Name("FCMToken"),
      object: nil,
      userInfo: tokenDict)
  }
}


