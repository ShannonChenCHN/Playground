//
//  ViewController.swift
//  EasedClock
//
//  Created by ShannonChen on 2017/1/30.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit


/*
 1. 在 storyboard 中布置好时钟图片素材的位置，注意时针、分针、秒针的位置
 2. 拖线
 3. 设置时针、分针、秒针的 anchorPoint 的值
 4. 根据当前时间计算时针、分针、秒针的角度位置
 5. 创建动画效果
 6. 创建计时器
 
 设计知识点：
 1. CATransform3D
 2. layer 的 anchorPoint 属性
 3. NSCalendar
 4. tranform 动画，自定义时间函数
 5. OptionSet 协议
 
 */

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var hourHand: UIImageView!
    @IBOutlet weak var minHand: UIImageView!
    @IBOutlet weak var secondHand: UIImageView!
    
    var timer: Timer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adjust anchor points
        hourHand.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0.9)
        minHand.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0.9)
        secondHand.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0.9)
        
        // start timer
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer: Timer) in
            self.updateHands(animated: true)
        })
        
        // Set up initial hand positions
        updateHands(animated: false)
        
    }

    func updateHands(animated: Bool) {
        // Convert time to hours, minutes, and seconds
        let calendar = NSCalendar.init(identifier: .gregorian)
        let components = calendar?.components([.hour, .minute, .second], from: Date())
        
        // calculate hour hand angle
        let hourAngle = (Double((components?.hour)!) / 12.0) * M_PI * 2
        
        // calculate minute hand angle
        let minAngle = (Double((components?.minute)!) / 60.0) * M_PI * 2
    
        // calculate second hand angle
        let secondAngle = (Double((components?.second)!) / 60.0) * M_PI * 2
        
        // Rotate hands
        set(angle: CGFloat(hourAngle), for: hourHand, animated: animated)
        set(angle: CGFloat(minAngle), for: minHand, animated: animated)
        set(angle: CGFloat(secondAngle), for: secondHand, animated: animated)
    }
    
    func set(angle: CGFloat, for hand: UIView, animated: Bool) {
        // generate transform
        let transform = CATransform3DMakeRotation(angle, 0, 0, 1);
        
        if animated {
            // create transform animation
            let animation = CABasicAnimation()
            animation.keyPath = "transform"
            animation.duration = 0.5
            animation.timingFunction = CAMediaTimingFunction.init(controlPoints: 1, 0, 0.75, 1)
            
            // apply animation
            hand.layer.transform = transform
            
            hand.layer.add(animation, forKey: nil)
            
        }
        else {
            
            // set transform directly
            hand.layer.transform = transform
        }
    }
}

