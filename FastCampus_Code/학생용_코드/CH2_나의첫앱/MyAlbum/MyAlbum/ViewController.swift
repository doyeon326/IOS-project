//
//  ViewController.swift
//  MyAlbum
//
//  Created by joonwon lee on 2020/02/01.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue: Int = 1000000
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showAlert() {
        // add alert
        let message = "가격은 \(currentValue) 입니다. "
        
        let alert = UIAlertController(title: "hello", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: { action in
            self.refresh()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func refresh() {
        let randomNum = arc4random_uniform(100000) + 1
        currentValue = Int(randomNum)
        priceLabel.text = "₩ \(currentValue)"
    }
    
}

