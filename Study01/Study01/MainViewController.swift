//
//  MainViewController.swift
//  Study01
//
//  Created by Tony Jung on 2020/09/14.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var leadingC: NSLayoutConstraint!
    @IBOutlet weak var trailingC: NSLayoutConstraint!
    @IBOutlet var menuView: UIView!
    var hamburgerMenuIsVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func hamburgerBtnTapped(_ sender: Any) {
        if !hamburgerMenuIsVisible {
            leadingC.constant = 150
            trailingC.constant = -150
            hamburgerMenuIsVisible = true
        }
        else {
            leadingC.constant = 0
            trailingC.constant = 0
            hamburgerMenuIsVisible = false
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("animation complete")
        }
    
    }
    


}
