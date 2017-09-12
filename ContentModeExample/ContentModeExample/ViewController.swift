//
//  ViewController.swift
//  ContentModeExample
//
//  Created by ShannonChen on 2017/9/8.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    let kAssetsImageName = "assetsImage"
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var customImageView: CustomDrawingImageView!
    
    
    var imageName: String? {
        didSet {
            if let imageName = imageName, imageName != kAssetsImageName {
                imageView.image = UIImage.init(named: imageName)
//                customImageView.image = UIImage.init(named: imageName)
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
    
//    var imageAlignment: UIImageViewAlignmentMask? {
//        didSet {
//            if let imageAlignment = imageAlignment {
//                imageView.alignment = imageAlignment
//            }
//            
//        }
//    }
    

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageName = "inspiration_01"
        contentMode = UIViewContentMode.scaleAspectFill
        clipToBounds = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let imageWH = 20 / 375.0 * UIScreen.main.bounds.size.width
        
        imageView.frame.size = CGSize.init(width: imageWH, height: imageWH)
        imageView.center = view.center

    }
    
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        
        // UIIMagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickController = UIImagePickerController()
        
        // Only allow photos to be taken, not taken.
        imagePickController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image
        imagePickController.delegate = self
        
        // Present the picker
        present(imagePickController, animated: true, completion: nil)
        
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // Dismiss the picker if the user cancelled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary contains multiple representaions of the image, and this uses the oringnal.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // set photoImageView to display the selected image
        imageView.image = selectedImage
//        customImageView.image = selectedImage
        
        imageName = kAssetsImageName
        
        // Dismiss the picker
        dismiss(animated: true, completion: nil)
    }

}

