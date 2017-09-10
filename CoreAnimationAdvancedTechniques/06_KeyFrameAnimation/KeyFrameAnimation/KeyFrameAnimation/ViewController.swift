//
//  ViewController.swift
//  KeyFrameAnimation
//
//  Created by ShannonChen on 2017/1/29.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    var bezierPath: UIBezierPath!
    var shipLayer: CALayer!
    
    
    @IBOutlet weak var layerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a path
        bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 150))
        bezierPath.addCurve(to: CGPoint(x: view.bounds.size.width - 30, y: 150),
                            controlPoint1: CGPoint(x: 75, y: 0),
                            controlPoint2: CGPoint(x: 225, y: 300))
        
        
        
        // Draw the path using a CAShapeLayer
        let pathLayer = CAShapeLayer()
        pathLayer.path = bezierPath.cgPath
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.lineWidth = 3.0
        layerView.layer.addSublayer(pathLayer)
        
        
        // Add the ship
        shipLayer = CALayer()
        shipLayer.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        shipLayer.position = CGPoint(x: 0, y: 150)
        shipLayer.contents = #imageLiteral(resourceName: "Ship").cgImage
        layerView.layer.addSublayer(shipLayer)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Create the key frame animation
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 4.0
        animation.path = bezierPath.cgPath
        animation.rotationMode = kCAAnimationRotateAuto
        shipLayer.add(animation, forKey: nil)
    }


}

