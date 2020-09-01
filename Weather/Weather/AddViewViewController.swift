//
//  AddViewViewController.swift
//  Weather
//
//  Created by Tony Jung on 2020/08/24.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit


class AddViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBOutlet weak var tfAddItem: UITextField!
   
    @IBAction func btnAddItem(_ sender: UIButton) {
        
        guard let tableViewVC = navigationController?.viewControllers.first as? ViewController else { return }

        tfAddItem.text = ""
        navigationController?.popViewController(animated: true)
    }
}
