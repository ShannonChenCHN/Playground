//
//  ViewController.swift
//  NSURLExampleInSwift
//
//  Created by ShannonChen on 2017/5/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Absolute URL and relative URL
        let baseURL = URL.init(string: "file:///user/Documents")
        let anURL = NSURL.init(string:"./Library/Cache", relativeTo: baseURL)
        
        if let absoluteString = anURL?.absoluteString {
            print(absoluteString)  // file:///user/Library/Cache
        }
        
        
        // Nested Types
    }

}

