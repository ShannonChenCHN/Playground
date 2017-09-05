//
//  AppDelegate.swift
//  NSNotificationPlayground
//
//  Created by ShannonChen on 2017/9/5.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let vc1 = ViewController.init(nibName: nil, bundle: nil)
        vc1.title = "vc 1"
        
        let vc2 = ViewController.init(nibName: nil, bundle: nil)
        vc2.title = "vc 2"
        
        let vc3 = ViewController.init(nibName: nil, bundle: nil)
        vc3.title = "vc 3"
        
        let vc4 = ViewController.init(nibName: nil, bundle: nil)
        vc4.title = "vc 4"
        
        let vc5 = ViewController.init(nibName: nil, bundle: nil)
        vc5.title = "vc 5"
        
        
        let tabBarController = UITabBarController.init()
        tabBarController.viewControllers = [vc1, vc2, vc3, vc4, vc5];
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        
        let delayQueue = DispatchQueue.init(label: "com.shannon.delayqueue")
        let additionalTime: DispatchTimeInterval = .seconds(5)
        delayQueue.asyncAfter(deadline: .now() + additionalTime) { 
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: ViewController.notificationName), object: nil)
        }
        
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


}

