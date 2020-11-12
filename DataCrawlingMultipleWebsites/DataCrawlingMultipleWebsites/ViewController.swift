//
//  ViewController.swift
//  DataCrawlingMultipleWebsites
//
//  Created by Tony Jung on 2020/11/11.
//

import UIKit
import WebKit


class ViewController: UIViewController{
    let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tappedNaver(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else { return }
        
        vc.urlString = "https://m.naver.com/"
        self.navigationController?.pushViewController(vc, animated: true)
        //1. webView를 다음 컨트롤러에 띄어야할까?
        //2. 코드정리
        //3. 데이터 전달할수있는 효율적인 방법?
    }
    @IBAction func tappedGoogle(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else { return }

        vc.urlString = "https://www.google.com/"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func tappedDaum(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else { return }
        
        vc.urlString = "https://m.daum.net/?nil_top=mobile"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
  
}

