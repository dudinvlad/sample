//
//  AppDelegate.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 20.10.2021.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import Macaroni
import Sentry

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    @Injected var notificationManager: NotificationManager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        IMAnalytics.registerBigDataConfigImplusAnalyticsPlist()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        FirebaseApp.configure()
        SentrySDK.start { options in
            options.dsn = "https://61add017558f411894e8bc202f85bf87@o201605.ingest.sentry.io/6071104"
            options.debug = true
            options.tracesSampleRate = 1.0
            options.beforeBreadcrumb = { crumb in
                return crumb
            }
        }
        registerNotification()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func registerNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound]
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }

    }
}
