//
//  ViewController.swift
//  FirstActivity
//
//  Created by Tony Jung on 2020/10/24.
//  Copyright © 2020 com.doyeon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var reference1: Person?
    var reference2: Person?
    var reference3: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //strong vs weak 
        reference1 = Person(name: "John Appleseed")
        // Prints "John Appleseed is being initialized"
        reference2 = reference1
        reference3 = reference1
        
        reference1 = nil
        reference2 = nil
        reference3 = nil
        // Prints "John Appleseed is being deinitialized"
    }


}

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}


