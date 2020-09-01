//
//  ViewController.swift
//  MyAlbum2
//
//  Created by Tony Jung on 2020/07/06.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue = 0

    @IBOutlet weak var pricelabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()

        // Do any additional setup after loading the view.
    }



    @IBAction func showAlert(_ sender: Any) {
        let message = "가격은 \(currentValue)입니다"
        //swing..interpration..?
        let alert = UIAlertController(title: "Hi", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {action in self.refresh()})
           
           alert.addAction(action)
           present(alert,animated: true,completion: nil)
         
 
    }
    
    func refresh(){
        let randomPrice = arc4random_uniform(10000)+1
         currentValue = Int(randomPrice)
         pricelabel.text = "\(currentValue)"
    }
}

