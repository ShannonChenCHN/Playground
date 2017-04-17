//
//  ViewController.swift
//  NullabilityDemo
//
//  Created by ShannonChen on 17/4/17.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aBook: Book = Book.init(name: "Bible")  // init!(name: String!)
        print(aBook.name);  //  var name: String! { get }
        
        let aBookWithAnnotations = BookWithAnnotations.init(name: "Notebook")  // init?(name: String)
        if let book = aBookWithAnnotations {
            print(book.name)  // var name: String { get }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

