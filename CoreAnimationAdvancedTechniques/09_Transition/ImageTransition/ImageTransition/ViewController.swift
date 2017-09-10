//
//  ViewController.swift
//  ImageTransition
//
//  Created by ShannonChen on 2017/1/29.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    let images = [#imageLiteral(resourceName: "Anchor"),
                  #imageLiteral(resourceName: "Cone"),
                  #imageLiteral(resourceName: "Igloo"),
                  #imageLiteral(resourceName: "Spaceship")]
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func switchImage(_ sender: UIButton) {
        
        // setup crossfade transition 
        let transition = CATransition()
        transition.type = kCATransitionFade
        
        // apply transition to image view backing layer
        imageView.layer.add(transition, forKey: nil)
        
        // cycle to next image
        
        var nextIndex = 0
        if let currentImage = imageView.image, let currentIndex = images.index(of: currentImage) {
            nextIndex = (currentIndex + 1) % images.count
        }
        
        imageView.image = images[nextIndex]
        
    }

}

