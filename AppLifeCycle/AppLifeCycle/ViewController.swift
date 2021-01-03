//
//  ViewController.swift
//  AppLifeCycle
//
//  Created by Tony Jung on 2020/10/31.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewdidLoad")
    }

    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
}

