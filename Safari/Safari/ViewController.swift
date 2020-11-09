//
//  ViewController.swift
//  Safari
//
//  Created by Tony Jung on 2020/11/02.
//

import UIKit
//import SafariServices
import WebKit
class ViewController: UIViewController {
    @IBOutlet var webview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.load(URLRequest(url: URL(string: "https://order.pay.naver.com/home?tabMenu=SHOPPING/")!))
    }

//    @IBAction func buttonTapped(){
//        let vc = SFSafariViewController(url: URL(string: "https://www.apple.com")!)
//        present(vc, animated: true)
//
//    }
    
}

