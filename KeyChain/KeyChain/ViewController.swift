//
//  ViewController.swift
//  KeyChain
//
//  Created by Tony Jung on 2020/11/07.
//

import UIKit
import KeychainAccess

class ViewController: UIViewController {

    @IBOutlet weak var highscorelabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Load keychain Value
        let keychain = Keychain(service: "com.doyeon.KeyChain")
        self.highscorelabel.text = keychain["HighScore"]
    }

    @IBAction func saveUpButton(_ sender: Any) {
        self.highscorelabel.text = "High Score: 100"
        let highScore = self.highscorelabel.text
        
        //Save data in keychain
        let keychain = Keychain(service: "com.doyeon.KeyChain")
        keychain["HighScore"] = highScore
    }
    
}

