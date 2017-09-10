//
//  SecondViewController.swift
//  TabBarTransition
//
//  Created by ShannonChen on 2017/1/29.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {
        self.title = "Second"
        self.tabBarItem.image = #imageLiteral(resourceName: "second")
    }


}
