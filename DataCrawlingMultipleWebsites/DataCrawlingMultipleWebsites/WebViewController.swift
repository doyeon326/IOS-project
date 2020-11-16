//
//  WebViewController.swift
//  DataCrawlingMultipleWebsites
//
//  Created by Tony Jung on 2020/11/12.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var urlString: String = ""
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()

    }
    func loadWebView(){
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        webView.frame = view.bounds
        webView.load(request)
        view.addSubview(webView)
        
        webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML", completionHandler: {(value, error) in
            print("INNER HTML \(value)")
        })
    }

}
extension WebViewController: WKNavigationDelegate {
    //왜 안불릴까? 
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Called when the navigation is complete.")
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Called when the web view begins to receive web content.")
    }
}

