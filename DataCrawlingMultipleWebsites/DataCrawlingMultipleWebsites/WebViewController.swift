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
        view.addSubview(webView)
        webView.navigationDelegate = self
        guard let url = URL(string: urlString) else { return }
        webView.frame = view.bounds
        webView.load(URLRequest(url: url))
       
        
        webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML", completionHandler: {(value, error) in
            print("INNER HTML \(value)")
        })
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Called when the navigation is complete.")
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Called when the web view begins to receive web content.")
    }
}

