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
    
    var imageName: String?
    var contentMode: UIViewContentMode?
    var lastController: UIViewController? {
        if let presentingViewController: UINavigationController = self.presentingViewController as? UINavigationController {
            
            return presentingViewController.childViewControllers.first!
        }
        return nil
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        imageName = lastController?.value(forKey: "imageName") as? String
        contentMode = lastController?.value(forKey: "contentMode") as? UIViewContentMode
        
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

        form +++ Section("Section1")
            <<< ActionSheetRow<String>() {
                $0.tag = "imageName";
                $0.title = "Image Name"
                $0.selectorTitle = "Select an Image to Show"
                $0.options = ["Inspiration_01", "Inspiration_02"]
                $0.value = imageName ?? "Inspiration_01"
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
            }
            
            <<< ActionSheetRow<String>(){
                $0.tag = "contentMode"
                $0.title = "Content Mode"
                $0.selectorTitle = "Specify a Content Mode for Image Displying"
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
    
    }

    
    
    @IBAction func dissmiss(_ sender: UIBarButtonItem) {
    
        navigationController?.dismiss(animated: true, completion: nil)
        
        
        let valuesDictionary = form.values()
        
        for item in valuesDictionary {
            print(item)
            if let item = item as? [String: String] {
                lastController?.setValue(item["value"], forKey: item["key"]!)
            }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
