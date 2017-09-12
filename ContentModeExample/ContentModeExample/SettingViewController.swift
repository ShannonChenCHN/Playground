//
//  SettingViewController.swift
//  ContentModeExample
//
//  Created by ShannonChen on 2017/9/8.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit
import Eureka



class SettingViewController: FormViewController {
    
    // MARK: Properties
    var imageName: String?
    var contentMode: UIViewContentMode?
    var clipToBounds: Bool?
//    var imageAlignment: UIImageViewAlignmentMask?
    
    
    var lastController: ViewController? {
        if let presentingViewController: UINavigationController = self.presentingViewController as? UINavigationController {
            
            return presentingViewController.childViewControllers.first as? ViewController
        }
        return nil
    }
    
    let contentModeMap: [UIViewContentMode: String] = [.scaleToFill : "scaleToFill",
                                                       .scaleAspectFit : "scaleAspectFit",
                                                       .scaleAspectFill : "scaleAspectFill",
                                                       .redraw : "redraw",
                                                       .center : "center",
                                                       .top : "top",
                                                       .bottom : "bottom",
                                                       .left : "left",
                                                       .right : "right",
                                                       .topLeft : "topLeft",
                                                       .topRight : "topRight",
                                                       .bottomLeft : "bottomLeft",
                                                       .bottomRight : "bottomRight"]
//    let alignmentMap: [UIImageViewAlignmentMask.RawValue: String] = [UIImageViewAlignmentMask.top.rawValue : "top",
//                                                                     UIImageViewAlignmentMask.left.rawValue : "left",
//                                                                     UIImageViewAlignmentMask.topLeft.rawValue : "topLeft",
//                                                                     UIImageViewAlignmentMask.center.rawValue : "center"]
//    
    
    
    

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageName = lastController?.imageName
        contentMode = lastController?.contentMode
        clipToBounds = lastController?.clipToBounds
//        imageAlignment = lastController?.imageAlignment

        form +++ Section("")
            <<< ActionSheetRow<String>() {
                $0.tag = "imageName";
                $0.title = "Image Name"
                $0.selectorTitle = "Select an image to show"
                $0.options = ["inspiration_01", "inspiration_02", "small_icon"]
                $0.value = imageName ?? "inspiration_01"
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
            }
            
            <<< ActionSheetRow<String>(){
                $0.tag = "contentMode"
                $0.title = "Content Mode"
                $0.selectorTitle = "Specify a content mode for image displying"
                $0.options = ["scaleToFill", "scaleAspectFit", "scaleAspectFill", "redraw", "center", "top", "bottom", "left", "right", "topLeft", "topRight", "bottomLeft", "bottomRight"]
                
                if let contentMode = contentMode, let value = contentModeMap[contentMode] {
                    $0.value = value
                } else {
                    $0.value = "scaleToFill"
                }
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
            }
            
//            <<< ActionSheetRow<String>() {
//                $0.tag = "alignment";
//                $0.title = "Image Alignment"
//                $0.selectorTitle = "Select a style to align the image."
//                $0.options = ["top", "left", "topLeft", "center"]
//                if let imageAlignment = imageAlignment, let value = alignmentMap[imageAlignment.rawValue] {
//                    $0.value = value
//                } else {
//                    $0.value = "none"
//                }
//                }
//                .onPresent { from, to in
//                    to.popoverPresentationController?.permittedArrowDirections = .up
//            }
        
            <<< ActionSheetRow<String>() {
                $0.tag = "clipToBounds"
                $0.title = "Clip To Bounds"
                $0.selectorTitle = "Should clip image content to the bounds of the image view?"
                $0.options = ["YES", "NO"]
                if let clipToBounds = clipToBounds, clipToBounds == true {
                    $0.value = "YES"
                } else {
                    $0.value = "NO"
                }

            }
        .onPresent{ from, to in
            to.popoverPresentationController?.permittedArrowDirections = .up
        }
    
    }

    
    
    @IBAction func dissmiss(_ sender: UIBarButtonItem) {
    
        navigationController?.dismiss(animated: true, completion: nil)
        
        
        let contentModeString = form.values()["contentMode"] as? String
        let contentMode = (contentModeMap as NSDictionary).allKeys(for: contentModeString!) as! [UIViewContentMode]
        lastController?.contentMode = contentMode.last
        
//        let alignmentString = form.values()["alignment"] as? String
//        let alignment = (alignmentMap as NSDictionary).allKeys(for: alignmentString!) as! [UIImageViewAlignmentMask.RawValue]
//        lastController?.imageAlignment = alignment.last.map { UIImageViewAlignmentMask(rawValue: $0) }
        

        let imageName = form.values()["imageName"] as? String
        if let imageName = imageName {
            lastController?.imageName = imageName
        }
        
        let clipToBounds = form.values()["clipToBounds"] as? String
        if let clipToBounds = clipToBounds {
            lastController?.clipToBounds = clipToBounds == "YES" ? true : false
        }
        
    }

}
