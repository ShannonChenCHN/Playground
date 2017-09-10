//
//  SecondViewController.swift
//  BouncyBall
//
//  Created by ShannonChen on 2017/1/30.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

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
        
        //set up animation parameters
        let fromValue = NSValue.init(cgPoint: CGPoint.init(x: 150, y: 32))
        let toValue = NSValue.init(cgPoint: CGPoint.init(x: 150, y: 268))
        let duration = 1.0
    
        
        //generate keyframes
        let frameCount = Int(duration * 60)
        var frames = [NSValue]()
        for i in 0..<frameCount {
            var time = 1 / Float(frameCount) * Float(i)
            
            // apply easing
            time = convertForBounceEaseOut(time: time)
            
            // add keyframe
            frames.append(interpolate(fromValue: fromValue, toValue: toValue, time: time) as! NSValue)
        }
        
        
        //create keyframe animation
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 1.0
        animation.values = frames
        
        // update model layer's value
        ballView.layer.position = CGPoint.init(x: 150, y: 268)
        
        //apply animation
        ballView.layer.add(animation, forKey: nil)
        
    }

    
    
    // MARK: Calculation
    func interpolateSingleValue(from: CGFloat, to: CGFloat, time: Float) -> CGFloat {
        return (to - from) * CGFloat(time) + from;
    }
    
    func interpolate(fromValue: Any, toValue: Any, time: Float) -> Any {

        if let fromValue = fromValue as? NSValue, let toValue = toValue as? NSValue {
            // get type
//            let type = fromValue.objCType
//            if strcmp(type, @encode(CGPoint)) == 0 {
                let from = fromValue.cgPointValue
                let to = toValue.cgPointValue
                let result = CGPoint.init(x: interpolateSingleValue(from: from.x, to: to.x, time: time),
                                          y: interpolateSingleValue(from: from.y, to: to.y, time: time))
            return NSValue.init(cgPoint: result)
//            }
        }
        
        //provide safe default implementation
        return (time < 0.5) ? fromValue : toValue
    }
    
    //From Robert Penner's web page (http://www.robertpenner.com/easing)
    func convertForBounceEaseOut(time: Float) -> Float {
        if (time < 4/11.0) {
            return (121 * time * time)/16.0;
        }
        else if (time < 8/11.0) {
            return (363/40.0 * time * time) - (99/10.0 * time) + 17/5.0;
        }
        else if (time < 9/10.0) {
            return (4356/361.0 * time * time) - (35442/1805.0 * time) + 16061/1805.0;
        }
        
        return (54/5.0 * time * time) - (513/25.0 * time) + 268/25.0;
    }

    

}
