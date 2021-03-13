//
//  ViewController.swift
//  ColorGradient
//
//  Created by Tony Jung on 2021/03/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient = CAGradientLayer()
         gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor, UIColor.systemRed.cgColor, UIColor.systemOrange.cgColor, UIColor.systemYellow.cgColor]
    
        gradient.type = .conic
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5, y: 0)

        view.layer.addSublayer(gradient)
        gradient.frame = view.frame

    }

}

