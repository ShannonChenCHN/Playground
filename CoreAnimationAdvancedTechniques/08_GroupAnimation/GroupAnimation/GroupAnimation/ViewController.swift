//
//  ViewController.swift
//  GroupAnimation
//
//  Created by ShannonChen on 2017/1/29.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a path
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 20, y: 150))
        bezierPath.addCurve(to: CGPoint(x: 350, y: 150),
                            controlPoint1: CGPoint(x: 100, y: 0),
                            controlPoint2: CGPoint(x: 250, y: 300))
        
        
        // draw the path using a CAShapeLayer
        let pathLayer = CAShapeLayer()
        pathLayer.path = bezierPath.cgPath
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.lineWidth = 3.0
        view.layer.addSublayer(pathLayer)
        
        
        // add a colored layer
        let colorLayer = CALayer()
        colorLayer.frame = CGRect.init(x: 0, y: 0, width: 64, height: 64)
        colorLayer.position = CGPoint.init(x: 20, y: 150)
        colorLayer.backgroundColor = UIColor.green.cgColor
        view.layer.addSublayer(colorLayer)
        
        
        // create the position animation
        let positionAnimation = CAKeyframeAnimation()
        positionAnimation.keyPath = "position"
        positionAnimation.path = bezierPath.cgPath
        positionAnimation.rotationMode = kCAAnimationRotateAuto
        
        // create the color animation
        let colorAnimation = CABasicAnimation()
        colorAnimation.keyPath = "backgroundColor"
        colorAnimation.toValue = UIColor.red.cgColor
        
        
        // create group animation
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, colorAnimation]
        groupAnimation.duration = 4.0
        
        
        // add the animation to the color layer
        colorLayer.add(groupAnimation, forKey: nil)
    }


}

