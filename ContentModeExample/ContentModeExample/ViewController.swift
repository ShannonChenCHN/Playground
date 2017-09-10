//
//  ViewController.swift
//  ContentModeExample
//
//  Created by ShannonChen on 2017/9/8.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageName: String? {
        didSet {
            if let imageName = imageName {
                imageView.image = UIImage.init(named: imageName)
            }
        }
    }
    var contentMode: UIViewContentMode? {
        didSet {

            if let contentMode = contentMode {
                imageView.contentMode = contentMode
            }
            
        }
    }
    
    var clipToBounds: Bool? {
        didSet {
            if let clipToBounds = clipToBounds {
                imageView.clipsToBounds = clipToBounds
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imageName = "inspiration_01"
        contentMode = UIViewContentMode.scaleToFill
        clipToBounds = true
    }
    

}

