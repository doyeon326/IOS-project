//
//  CoreAnimationSimpleViewController.swift
//  Animation
//
//  Created by Tony Jung on 2021/02/09.
//

import UIKit

class CoreAnimationSimpleViewController: UIViewController {

    let shapeview = UIView()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setTitle("hello", for: .normal)
        button.frame = CGRect(x: 100, y: 400, width: 100, height: 30)
        button.backgroundColor = .black
      
        shapeview.backgroundColor = .cyan
        shapeview.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        shapeview.layer.cornerRadius = shapeview.frame.width/2
        view.addSubview(shapeview)
        view.addSubview(button)
        
 
    }
    
    @objc func buttonTapped(){
        UIView.animate(withDuration: 2.0) {
            self.shapeview.frame = CGRect(x: 100, y: 100, width: 300, height: 300)
            self.shapeview.center = self.view.center
            self.shapeview.layer.cornerRadius = self.shapeview.frame.width/2
        }
    }

}
