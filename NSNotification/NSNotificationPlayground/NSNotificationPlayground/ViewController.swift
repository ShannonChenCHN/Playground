//
//  ViewController.swift
//  NSNotificationPlayground
//
//  Created by ShannonChen on 2017/9/5.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static let notificationName = "notificationTest"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let red: CGFloat = CGFloat(arc4random() % 256) / 256.0
        let green: CGFloat = CGFloat(arc4random() % 256) / 256.0
        let blue: CGFloat = CGFloat(arc4random() % 256) / 256.0
        let alpha: CGFloat = CGFloat(arc4random() % 256) / 256.0
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNotification), name: NSNotification.Name.init(ViewController.notificationName), object: nil)
    }

    
    /// 收到通知
    func didReceiveNotification() {
        print(title ?? "");
    }
}

