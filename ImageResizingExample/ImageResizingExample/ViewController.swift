//
//  ViewController.swift
//  ImageResizingExample
//
//  Created by ShannonChen on 2017/5/25.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit
import ImageIO
import Accelerate

class ViewController: UIViewController {
    
    
    let screenScale = UIScreen.main.scale
    @IBOutlet weak var imageView: UIImageView!

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let originalImage = #imageLiteral(resourceName: "qrcode")
        imageView.contentMode = .scaleAspectFit
        
//        imageView.image = originalImage
//        imageView.image = scaledImageByUIKit(with: originalImage, scale: 8)
        imageView.image = scaledImageByCoreGraphics(with: originalImage, scale: 4)
//        imageView.image = scaledImageByImageIO(with: originalImage, scale: 1)
//        imageView.image = scaledImageByCoreImage(with: originalImage, scale: 0.5)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let size = imageView.image?.size {
            
            imageView.frame = CGRect.init(origin: CGPoint(x: 0, y: 0), size: size)
            imageView.center = CGPoint.init(x: view.bounds.width * 0.5, y: view.bounds.height * 0.5)
        }
    }
    
    // MARK: Scale Approaches
    
    // 1.UIKit approach
    func scaledImageByUIKit(with originalImage: UIImage!, scale: CGFloat) -> UIImage? {
        
        guard let image = originalImage else {
            return nil
        }
        
        let targetSize = __CGSizeApplyAffineTransform(image.size, CGAffineTransform.identity.scaledBy(x: scale, y: scale)) // the target size of the scaled image.
        let hasAlpha = false  // for images without transparency (i.e. an alpha channel)
        let scaleFactor: CGFloat = 0.0 // the display scale factor, automatically use scale factor of main screen
        
        // 1. Creates a temporary rendering context into which the original is drawn.
        UIGraphicsBeginImageContextWithOptions(targetSize, hasAlpha, scaleFactor)
        
        // 2. draw image in target size on bitmap-based graphics context
        originalImage.draw(in: CGRect.init(origin: CGPoint(x: 0.0, y: 0.0), size: targetSize))
        
        // 3. retrieve image from raphics context
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 4. cleanup
        UIGraphicsEndImageContext()
        
        return scaledImage
        
    }

    // 2.CoreGraphics
    func scaledImageByCoreGraphics(with originalImage: UIImage!, scale: CGFloat) -> UIImage? {
        guard let image = originalImage else {
            return nil
        }
        
        guard let cgImage = image.cgImage else {
            return nil
        }
        
        let targetWidth = CGFloat(cgImage.width) * scale
        let targetHeight = CGFloat(cgImage.height) * scale
        let targetSize = CGSize.init(width: targetWidth, height: targetHeight)
        
        // construct a context with desired dimensions and amount of memory for each channel within a given colorspace
        let context = CGContext.init(data: nil,
                                     width: Int(targetWidth),
                                     height: Int(targetHeight),
                                     bitsPerComponent: cgImage.bitsPerComponent,
                                     bytesPerRow:0,
                                     space: cgImage.colorSpace!,
                                     bitmapInfo: cgImage.bitmapInfo.rawValue)
        context?.interpolationQuality = .none  // CGContextSetInterpolationQuality allows for the context to interpolate pixels at various levels of fidelity
        context?.draw(cgImage, in: CGRect.init(origin: CGPoint(), size:targetSize)) //  draw(_,in:) allows for the image to be drawn at a given size and position, allowing for the image to be cropped on a particular edge or to fit a set of image features, such as faces
        
        let scaledImage = context?.makeImage().flatMap{UIImage.init(cgImage: $0)}  // creates a CGImage from the context
        
        return scaledImage
    }
    
    // 4.ImageIO
    func scaledImageByImageIO(with originalImage: UIImage!, scale: CGFloat) -> UIImage? {
        guard let image = originalImage else {
            return nil
        }
        
        let options: [NSString: Any] = [
            kCGImageSourceThumbnailMaxPixelSize: max(image.size.width * screenScale, image.size.height * screenScale) * scale,
            kCGImageSourceCreateThumbnailFromImageAlways: true
        ]
        
        
        let imageSource = CGImageSourceCreateWithData(UIImagePNGRepresentation(image) as! CFData, nil)
        let scaledImage = CGImageSourceCreateThumbnailAtIndex(imageSource!, 0, options as CFDictionary?).map{UIImage.init(cgImage: $0)}
      
        return scaledImage
    }
    
    // 5.CoreImage
    func scaledImageByCoreImage(with originalImage: UIImage!, scale: CGFloat) -> UIImage? {
        guard let image = originalImage else {
            return nil
        }
 
        
        let filter = CIFilter(name: "CILanczosScaleTransform")!
        filter.setValue(CIImage.init(image: image), forKey: kCIInputImageKey)
        filter.setValue(scale, forKey: kCIInputScaleKey)
        filter.setValue(1.0, forKey: kCIInputAspectRatioKey)
        let outputImage = filter.outputImage!
        
        
        // A CIContext is used to create a UIImage by way of a CGImageRef intermediary representation, since UIImage(CIImage:) doesn’t often work as expected.
        // Creating a CIContext is an expensive operation, so a cached context should always be used for repeated resizing. A CIContext can be created using either the GPU or the CPU (much slower) for rendering—use the kCIContextUseSoftwareRenderer key in the options dictionary to specify which.
        let context = CIContext(options: [kCIContextUseSoftwareRenderer: false])
        
        let scaledImage = UIImage(cgImage: context.createCGImage(outputImage, from: outputImage.extent)!)
        
        return scaledImage
    }
    
    // 6. AccelerateFramework
//    func scaledImageByAccelerateFramework(with originalImage: UIImage!, scale: CGFloat) -> UIImage? {
//        guard let image = originalImage else {
//            return nil
//        }
//        
//        let cgImage = originalImage.cgImage
//        
//    }
}

