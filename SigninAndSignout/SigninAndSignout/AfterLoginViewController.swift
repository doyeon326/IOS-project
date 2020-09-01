//
//  AfterLoginViewController.swift
//  SigninAndSignout
//
//  Created by Tony Jung on 2020/08/18.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class AfterLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func popToPrev(){
        self.navigationController?.popViewController(animated: true)
    }

}
