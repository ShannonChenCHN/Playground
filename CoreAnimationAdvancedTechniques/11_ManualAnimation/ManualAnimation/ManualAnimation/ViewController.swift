//
//  ViewController.swift
//  ManualAnimation
//
//  Created by ShannonChen on 2017/1/30.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var containerView: UIView!
    var doorLayer: CALayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add the door
        self.doorLayer = CALayer()
        self.doorLayer.frame = CGRect.init(x: 0, y: 0, width: 128, height: 256)
        self.doorLayer.position = CGPoint.init(x: 150 - 64, y: 150) // position 是什么❓
        self.doorLayer.anchorPoint = CGPoint.init(x: 0, y: 0.5) // anchorPoint 是什么❓
        self.doorLayer.contents = #imageLiteral(resourceName: "Door").cgImage
        self.containerView.layer.addSublayer(doorLayer)
        
        // apply perspective transform
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
        self.containerView.layer.sublayerTransform = perspective
        
        // add pan gesture recognizer to handle swips
        let pan = UIPanGestureRecognizer()
        pan.addTarget(self, action: #selector(pan(pan:)))
        self.view.addGestureRecognizer(pan)
        
        // pause all layer animations
        self.doorLayer.speed = 0.0
        
        // apple swing animation (which won't play because layer is paused)
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.y"
        animation.toValue = NSNumber.init(value: -M_PI_2)
        animation.duration = 1.0
        self.doorLayer.add(animation, forKey: nil)
    }

    
    func pan(pan: UIPanGestureRecognizer) {
        //get horizontal component of pan gesture
        var x = pan.translation(in: self.view).x
        
        //convert from points to animation duration
        //using a reasonable scale factor
        x /= 200.0
        
        //update timeOffset and clamp result
        var timeOffset = self.doorLayer.timeOffset
        timeOffset = min(0.999, max(Double(0), Double(timeOffset) - Double(x)))
        self.doorLayer.timeOffset = timeOffset
        
        // reset pan gesture
        pan.setTranslation(CGPoint.zero, in: self.view)
        
        
    }
}

