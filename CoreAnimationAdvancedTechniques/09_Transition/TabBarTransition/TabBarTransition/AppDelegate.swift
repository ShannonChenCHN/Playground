//
//  AppDelegate.swift
//  TabBarTransition
//
//  Created by ShannonChen on 2017/1/29.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    // MARK: Properties
    private let window: UIWindow = UIWindow.init(frame: UIScreen.main.bounds)
    let tabBarController = UITabBarController()
    

    // MARK: UIApplicationDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        tabBarController.viewControllers = [FirstViewController(), SecondViewController()]
        tabBarController.delegate = self
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    // MARK: UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // set up crossfade transition
        let transition = CATransition()
        transition.type = kCATransitionFade
        
        
        // apply transition to tab bar controller's view
        tabBarController.view.layer.add(transition, forKey: nil)

    }
    

}

