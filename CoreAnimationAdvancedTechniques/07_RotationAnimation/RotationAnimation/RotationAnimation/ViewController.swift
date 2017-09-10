//
//  ViewController.swift
//  RotationAnimation
//
//  Created by ShannonChen on 2017/1/29.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var containerView: UIView!
    
    var shipLayer: CALayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add the ship
        shipLayer = CALayer()
        shipLayer.frame = CGRect(x: 0, y: 0, width: 128, height: 128)
        shipLayer.position = CGPoint(x: 150, y: 150)
        shipLayer.contents = #imageLiteral(resourceName: "Ship").cgImage
        containerView.layer.addSublayer(shipLayer)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // animate the ship rotation
        let animation = CABasicAnimation()
        animation.duration = 2.0
//        animation.keyPath = "transform"
//        animation.toValue = NSValue.init(caTransform3D: CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1))
        animation.keyPath = "transform.rotation"
        animation.toValue = NSNumber.init(value: -M_PI * 2)
        shipLayer.add(animation, forKey: nil)
    }

}

