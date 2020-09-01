//
//  ViewController.swift
//  SigninAndSignout
//
//  Created by Tony Jung on 2020/08/17.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    
    
    
    @IBAction func checkUser(_ sender: Any) {
        if (nameField.text == UserInformation.shared.name && pwField.text == UserInformation.shared.pw){
            
            print(nameField.text!)
            
           let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "AfterLoginViewController") as! AfterLoginViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let dialogMessage = UIAlertController(title: "Confirm", message: "틀렸습니다 다시 로그인해주세요", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: {(action) -> Void in
                print("Ok button tapped")
            })
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
    
    }
    
    
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

