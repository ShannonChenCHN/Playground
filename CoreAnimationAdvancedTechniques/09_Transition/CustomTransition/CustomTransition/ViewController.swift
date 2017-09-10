//
//  ViewController.swift
//  CustomTransition
//
//  Created by ShannonChen on 2017/1/29.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    

    @IBAction func performTransition(_ sender: UIButton) {
        //preserve the current view snapshot
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let coverImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //insert snapshot view in front of this one
        let coverView = UIImageView.init(image: coverImage)
        coverView.frame = self.view.bounds
        self.view.addSubview(coverView)
        
        //update the view (we'll simply randomize the layer background color)
        let red = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
        let green = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
        let blue = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
        self.view.backgroundColor = UIColor.init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
        
        //perform animation (anything you like)
        UIView.animate(withDuration: 1.0, animations: { 
            //scale, rotate and fade the view
            var transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
            transform = transform.rotated(by: CGFloat(M_PI_2))
            coverView.transform = transform
            coverView.alpha = 0.0
            
        }) { (finished: Bool) in
            //remove the cover view now we're finished with it
            coverView.removeFromSuperview()
        }
    }

}

