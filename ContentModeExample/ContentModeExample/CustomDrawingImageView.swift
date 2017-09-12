//
//  CustomDrawingImageView.swift
//  ContentModeExample
//
//  Created by ShannonChen on 2017/9/11.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit


/// 自己绘制图片方式的 image view
class CustomDrawingImageView: UIView {
    
    var image: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        
        if let image = image {
            let imageHeight = image.size.height
            let imageWidth = image.size.width
            if (imageHeight / imageWidth > bounds.size.height / bounds.size.width) {
                
                let width = bounds.size.width
                let height = imageHeight * (width / imageWidth)
                let rect = CGRect.init(origin: CGPoint(), size: CGSize.init(width: width, height: height))
                
                image.draw(in: rect)
            }
        }
        
    }
    
    
}
