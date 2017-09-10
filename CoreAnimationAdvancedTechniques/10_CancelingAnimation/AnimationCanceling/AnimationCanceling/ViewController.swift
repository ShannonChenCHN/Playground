//
//  ViewController.swift
//  AnimationCanceling
//
//  Created by ShannonChen on 2017/1/29.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    static let rotateAnimationKey = "rotateAnimation"

    // MARK: Properties
    var shipLayer: CALayer!
    
    @IBOutlet weak var imageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add the ship
        shipLayer = CALayer()
        shipLayer.frame = CGRect.init(x: 0, y: 0, width: 128, height: 128)
        shipLayer.position = CGPoint.init(x: 150, y: 150)
        shipLayer.contents = #imageLiteral(resourceName: "Ship").cgImage
        self.imageView.layer.addSublayer(shipLayer)
    }

    // MARK: Button Action
    @IBAction func startAnimation(_ sender: UIButton) {
        //animate the ship rotation
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation"
        animation.duration = 1.0
        animation.byValue = NSNumber.init(value: M_PI * 2)
        animation.delegate = self
        self.shipLayer.add(animation, forKey: ViewController.rotateAnimationKey)
    }

    // MARK: CAAnimationDelegate
    @IBAction func stopAnimation(_ sender: UIButton) {
        self.shipLayer.removeAnimation(forKey: ViewController.rotateAnimationKey)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {

        print("\(ViewController.rotateAnimationKey) animation stopped (finished: \(flag))")
    }
}

