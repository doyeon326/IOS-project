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
    }

}
