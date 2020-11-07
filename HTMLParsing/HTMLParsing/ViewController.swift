//
//  ViewController.swift
//  HTMLParsing
//
//  Created by Tony Jung on 2020/11/05.
//

import UIKit
import WebKit
import HTMLKit



class ViewController: UIViewController {
    private let webView: WKWebView = {
        let prefs = WKPreferences()
        
        prefs.javaScriptEnabled = true
        let config = WKWebViewConfiguration()
        config.preferences = prefs
        let webVIew = WKWebView(frame: .zero, configuration: config)
        return webVIew
    }()


    let urlString = "https://www.google.com/search?q=iphone+12&sxsrf=ALeKk02a_ajGo3h6LIyRKKOR4k34izfnBw:1604575918542&source=lnms&tbm=isch&sa=X&ved=2ahUKEwijvI6Np-vsAhXBGaYKHVoSCOYQ_AUoAXoECBMQAw&biw=885&bih=678"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.frame = view.bounds
        webView.navigationDelegate = self
        guard let url = URL(string: urlString) else {
            return
        }
        webView.load(URLRequest(url: url))
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //parsing
        parseImages()
    }
    
    func parseImages(){
        // <img src="">
        webView.evaluateJavaScript("document.body.innerHTML") { result, error in
            guard let html = result as? String, error == nil else {
                return
            }
            let document = HTMLDocument(string: html)
            print("created HTML")
            let images: [String] = document.querySelectorAll("img").compactMap({element in
                guard let src = element.attributes["src"] as? String else {
                    return nil
                }
                return src
            })
            print("Found \(images.count) images\n ")
            print(images)
            
        }
    }
    
}
    
    
    
    
    
    
