//
//  ViewController.swift
//  EasingKeyFrameAnimation
//
//  Created by ShannonChen on 2017/1/30.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static let DefaultColor = UIColor.blue
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ViewController.DefaultColor
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // create a keyframe aniamtion
        let animation = CAKeyframeAnimation()
        animation.keyPath = "backgroundColor"
        animation.duration = 2.0
        animation.values = [
        ViewController.DefaultColor.cgColor,
        UIColor.red.cgColor,
        UIColor.green.cgColor,
        ViewController.DefaultColor.cgColor
        ]
        
        
        // add timing function
        let fun = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        animation.timingFunctions = [fun, fun, fun]
        
        // apply animation to layer
        view.layer.add(animation, forKey: nil)
        
        
    }
}

