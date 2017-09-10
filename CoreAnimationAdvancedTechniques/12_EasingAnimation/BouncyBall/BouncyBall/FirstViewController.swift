//
//  FirstViewController.swift
//  BouncyBall
//
//  Created by ShannonChen on 2017/1/30.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var containerView: UIView!
    var ballView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // add ball image view
        ballView = UIImageView.init(image: #imageLiteral(resourceName: "Ball"))
        containerView.addSubview(ballView)
        
        // animate
        animate()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // replay animation on tap
        animate()
    }
    
    func animate() {
        //reset ball to top of screen
        ballView.center = CGPoint.init(x: 150, y: 32)
        
        //create keyframe animation
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 1.0
        animation.values = [
            NSValue.init(cgPoint: CGPoint.init(x: 150, y: 32)),
            NSValue.init(cgPoint: CGPoint.init(x: 150, y: 268)),
            NSValue.init(cgPoint: CGPoint.init(x: 150, y: 140)),
            NSValue.init(cgPoint: CGPoint.init(x: 150, y: 268)),
            NSValue.init(cgPoint: CGPoint.init(x: 150, y: 220)),
            NSValue.init(cgPoint: CGPoint.init(x: 150, y: 268)),
            NSValue.init(cgPoint: CGPoint.init(x: 150, y: 250)),
            NSValue.init(cgPoint: CGPoint.init(x: 150, y: 268)) // 8 items
        ]
        
        animation.timingFunctions = [
        CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn),
        CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut),
        CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn),
        CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut),
        CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn),
        CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut),
        CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)  // 7 items
        ]
        
        animation.keyTimes = [0.0, 0.3, 0.5, 0.7, 0.8, 0.9, 0.95, 1.0] // 8 items
        
        // update model layer
        ballView.layer.position = CGPoint.init(x: 150, y: 268)
        
        // apply animation
        ballView.layer.add(animation, forKey: nil)
        
    }

}
