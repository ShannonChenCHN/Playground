//
//  ViewController.swift
//  UIKitTransition
//
//  Created by ShannonChen on 2017/1/29.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    let images = [#imageLiteral(resourceName: "Anchor"), #imageLiteral(resourceName: "Cone"), #imageLiteral(resourceName: "Igloo"), #imageLiteral(resourceName: "Spaceship")]
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: Button Action
    @IBAction func switchImage(_ sender: UIButton) {
        
        UIView.transition(with: imageView, duration: 1.0, options: .transitionFlipFromLeft, animations: { 
            // cycle to next image
            var nextIndex = 0
            if let currentImage = self.imageView.image, let currentIndex = self.images.index(of: currentImage) {
                nextIndex = (currentIndex + 1) % self.images.count
            }
            self.imageView.image = self.images[nextIndex]
            
            
            }, completion: nil)
    }

}

