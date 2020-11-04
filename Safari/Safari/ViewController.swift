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
        webview.load(URLRequest(url: URL(string: "https://nid.naver.com/nidlogin.login?svctype=262144&amp;url=http://m.naver.com/aside/")!))
    }

//    @IBAction func buttonTapped(){
//        let vc = SFSafariViewController(url: URL(string: "https://www.apple.com")!)
//        present(vc, animated: true)
//
//    }
    
}

