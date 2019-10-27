//
//  AppDelegate.swift
//  FourMe
//
//  Created by Lars Klassen on 10/26/19.
//  Copyright © 2019 The SilverLogic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let center =  UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
        }
        
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        let center =  UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Input your data"
        content.body = "Input your data"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:1.0, repeats: false)
        let request = UNNotificationRequest(identifier: "HLTHHack", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            NSLog("Notification request error")
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let tabController = self.window!.rootViewController as! UITabBarController
        if let vc = tabController.selectedViewController as? DashboardViewController {
            vc.updateDataAfterTime()
        }
        
        completionHandler()
    }

}

