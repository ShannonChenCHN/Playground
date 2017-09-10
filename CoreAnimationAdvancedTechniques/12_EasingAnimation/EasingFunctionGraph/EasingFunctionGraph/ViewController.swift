//
//  ViewController.swift
//  EasingFunctionGraph
//
//  Created by ShannonChen on 2017/1/30.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Create the timing function
//        let function = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        let function = CAMediaTimingFunction.init(controlPoints: 1, 0, 0.75, 1)
        
        // Get control points
        var controlPoint0: [Float] = Array.init(repeating: 0.0, count: 2)
        var controlPoint1: [Float] = Array.init(repeating: 0.0, count: 2)
        var controlPoint2: [Float] = Array.init(repeating: 0.0, count: 2)
        var controlPoint3: [Float] = Array.init(repeating: 0.0, count: 2)
        

        function.getControlPoint(at: 0, values: &controlPoint0)
        function.getControlPoint(at: 1, values: &controlPoint1)
        function.getControlPoint(at: 2, values: &controlPoint2)
        function.getControlPoint(at: 3, values: &controlPoint3)
        
        // Create curve
        let bezierPath = UIBezierPath()
        bezierPath.move(to: pointWith(array: controlPoint0))
        bezierPath.addCurve(to: pointWith(array: controlPoint3),
                            controlPoint1: pointWith(array: controlPoint1),
                            controlPoint2: pointWith(array: controlPoint2))
        
        // scale the path up to a reasonable size for display, 
        // we use container view's width--200pt here
        bezierPath.apply(CGAffineTransform.init(scaleX: 200, y: 200))
        
        // Create shape layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4.0
        shapeLayer.path = bezierPath.cgPath
        containerView.layer.addSublayer(shapeLayer)
        
        // Flip geometry so that (0, 0) is in the bottom-left
        containerView.layer.isGeometryFlipped = true

    }

    
    func pointWith(array: [Float]) -> CGPoint {
        guard array.count == 2 else {
            return CGPoint.zero
        }
        return CGPoint.init(x: CGFloat(array[0]), y: CGFloat(array[1]))
    }

}

