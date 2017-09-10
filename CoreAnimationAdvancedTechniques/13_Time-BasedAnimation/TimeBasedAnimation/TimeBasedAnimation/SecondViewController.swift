//
//  SecondViewController.swift
//  TimeBasedAnimation
//
//  Created by ShannonChen on 2017/1/30.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var containerView: UIView!
    var ballView: UIImageView!
    
    var timer: CADisplayLink!
    var duration: Float!
    var timeOffset: Float!
    var lastStep: CFTimeInterval!
    
    var fromValue: Any!
    var toValue: Any!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add ball image view
        ballView = UIImageView.init(image: #imageLiteral(resourceName: "Ball"))
        containerView.addSubview(ballView)
        
        // animate
        animate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // relpay animation on tap
        animate()
    }
    
    
    func animate() {
        // reset ball to top screen
        ballView.center = CGPoint.init(x: 150, y: 32)
        
        // configure the animation
        duration = 1.0
        timeOffset = 0.0
        fromValue = NSValue.init(cgPoint: CGPoint.init(x: 150, y: 32))
        toValue = NSValue.init(cgPoint: CGPoint.init(x: 150, y: 268))
        
        // stop the timer if it's already running
        if timer != nil {
            timer.invalidate()
        }
        
        
        // start the timer
        lastStep = CACurrentMediaTime()
        timer = CADisplayLink.init(target: self, selector: #selector(step))
        timer.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
        
    }
    
    func step() {
        
        // calculate time deta
        let thisStep = CACurrentMediaTime()
        let stepDuration = thisStep - lastStep
        lastStep = thisStep
        
        // update time offset
        timeOffset = min(timeOffset + Float(stepDuration), duration)
        
        //get normalized time offset (in range 0 - 1)
        var timePercentage = timeOffset / duration
        
        //apply easing
        timePercentage = convertForBounceEaseOut(time: timePercentage)
        
        //interpolate position
        let position = interpolate(fromValue: fromValue, toValue: toValue, time: timePercentage)
        
        //move ball view to new position
        if let position = position as? NSValue {
            ballView.center = position.cgPointValue
        }
        else {
            return
        }
        
        
        //stop the timer if we've reached the end of the animation
        if timeOffset >= duration {
            timer.invalidate()
            timer = nil
        }
        
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
