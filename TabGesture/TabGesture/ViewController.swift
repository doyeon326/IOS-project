//
//  ViewController.swift
//  TabGesture
//
//  Created by Tony Jung on 2020/08/17.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    //3가지 방법 : 1. action, 2. code 3. delegate
    @IBAction func tapView(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGesture: UITapGestureRecognizer =  UITapGestureRecognizer()
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
//        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapView(_:)))
//
//        self.view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return false
    }

}

