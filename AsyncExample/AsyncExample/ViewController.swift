//
//  ViewController.swift
//  AsyncExample
//
//  Created by Tony Jung on 2020/08/31.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func touchUpDownloadButton(_ sender: UIButton){
        //이미지 다운로드 -> 이미지 뷰에 셋팅
         //https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg
        //info.plist 설정
        let imageURL: URL = URL(string: "https://eskipaper.com/images/large-2.jpg")!
       
        
        OperationQueue().addOperation {
            //안하게 되면 앱이 작동아 안되는거같은 현상을 볼 수 있다. 
            let imageData: Data = try! Data.init(contentsOf: imageURL) //동기메서드
            let image: UIImage = UIImage(data: imageData)!
                   
            OperationQueue.main.addOperation {
                //UI관련해서는 무조건 메인에서 이루어져야한다.
                 self.imageView.image = image
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

