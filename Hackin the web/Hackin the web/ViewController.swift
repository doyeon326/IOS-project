//
//  ViewController.swift
//  Hackin the web
//
//  Created by Tony Jung on 2020/11/09.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    let webView = WKWebView()

    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let url = URL(string: "https://order.pay.naver.com/home?tabMenu=SHOPPING")!
        let request = URLRequest(url: url)
        
        //to show webview [not required]
        webView.frame = CGRect(x: 0, y: 500, width: 300, height: 300)
        webView.load(request)
        //not required
        view.addSubview(webView)
        
        
    }

    @IBAction func onSignInTapped(){
        switch counter {
        case 0:
            //Email //id
            //Passwd
            
           webView.evaluateJavaScript("document.getElementById('id').value='\(emailTF.text!)'", completionHandler: nil )
            
            webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML", completionHandler:  {(value, error) in
                print("INNER HTML \(value)")
                print("ERROR \(error)")
            } )
        case 1:
            webView.evaluateJavaScript("document.getElementById('pw').value='\(passwordTF.text!)'", completionHandler: nil )
            
        case 2: webView.evaluateJavaScript("document.getElementById('frmNIDLogin').submit();", completionHandler: nil)
        case 3: break
        case 4: break
        default: break
        }
        counter += 1
    }
}

