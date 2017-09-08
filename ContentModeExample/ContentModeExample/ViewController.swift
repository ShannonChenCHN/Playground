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
            imageView.image = UIImage.init(named: imageName!)
        }
    }
    var contentMode: UIViewContentMode? {
        didSet {
            imageView.contentMode = contentMode!
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imageName = "inspiration_01"
        contentMode = UIViewContentMode.scaleToFill
    }

    

}

