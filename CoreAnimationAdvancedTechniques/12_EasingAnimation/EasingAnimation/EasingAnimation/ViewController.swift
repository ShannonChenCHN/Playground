//
//  ViewController.swift
//  EasingAnimation
//
//  Created by ShannonChen on 2017/1/30.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    var colorLayer: CALayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a red layer
        colorLayer = CALayer()
        colorLayer.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        colorLayer.position = CGPoint.init(x: view.bounds.size.width / 2.0, y: view.bounds.size.height / 2.0)
        colorLayer.anchorPoint = CGPoint.init(x: 0.5, y: 0)
        colorLayer.backgroundColor = UIColor.red.cgColor
        view.layer.addSublayer(colorLayer)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        transactionEasing {
//            // set the position
//            colorLayer.position = touches.first!.location(in: view)
//        }
        
        UIKitEasing {
            // set the position
            self.colorLayer.position = touches.first!.location(in: self.view)
        }
    }
    
    func transactionEasing(positionSetting: () -> Void) {
        // configure the transition
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut))
        
        // set the position
        positionSetting()
        
        // commit the transaction
        CATransaction.commit()

    }

    func UIKitEasing(positionSetting: @escaping () -> Void) {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
            positionSetting()
            }, completion: { (finished: Bool) in
            
        })
    }

}

