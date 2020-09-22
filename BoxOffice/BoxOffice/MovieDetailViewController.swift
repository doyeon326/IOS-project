//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Tony Jung on 2020/09/23.
//  Copyright © 2020 com.doyeon. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet var duration: UIView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var movietitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var totalViewer: UILabel!
    @IBOutlet weak var userRating: UILabel!
    @IBOutlet weak var reservationRating: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//todo
    //전 스토리보드에서 (term)을 받을것.
    //받은 term 을 가지고 전에 만들었던 JsonParsing을 해서 관련 정보를 가져올것
    //생각해야할것 마지막 뷰 (높이를 어떻게 설정해 줄건지?)
    
//implementation
    //싱글톤을 써서 객체를 저장해서 쓸수 있도록 구현?
    //viewmodel 만들기


}

