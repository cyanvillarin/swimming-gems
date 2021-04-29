//
//  AppDelegate.swift
//  CatalogueAppTemplate
//
//  Created by CYAN on 2021/04/28.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
      // Firebase Config
      FirebaseApp.configure()
      
      // Google Ads Config
      GADMobileAds.sharedInstance().start(completionHandler: nil)
      GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["90ff99b01dbecf0e7f27515d1b4cd5b6"]
      
      // Set the flags to false since the app has just started
      UserDefaults.standard.set(false, forKey: "isAdRequested")
      UserDefaults.standard.set(false, forKey: "isAdShown")
      
      return true
   }

   // MARK: UISceneSession Lifecycle

   @available(iOS 13.0, *)
   func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      // Called when a new scene session is being created.
      // Use this method to select a configuration to create the new scene with.
      return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
   }

   @available(iOS 13.0, *)
   func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
      // Called when the user discards a scene session.
      // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
      // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
   }


}

