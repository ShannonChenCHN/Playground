//
//  ViewController.swift
//  HalfPixelDemo
//
//  Created by ShannonChen on 17/4/27.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let halfPixelLine = UIView.init(frame: CGRect.init(x: 100, y: 100, width:0.25, height: 170))
        halfPixelLine.backgroundColor = UIColor.gray
        halfPixelLine.layer.allowsEdgeAntialiasing = true
        self.view.addSubview(halfPixelLine)
    }

    


}

