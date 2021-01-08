//
//  ViewController.swift
//  UIBotton
//
//  Created by Tony Jung on 2021/01/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //two ways to control target action in UIControl
        let button = UIButton(type: .custom, primaryAction: UIAction(handler: { (_) in
            print("clicked")
        }))
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        button.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        button.setTitle("hello", for: .normal)
        view.addSubview(button)
    }
    
    @objc func tappedButton(){
        print("clicked")
    }
}

