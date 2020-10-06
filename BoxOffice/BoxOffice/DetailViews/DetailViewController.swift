//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by Tony Jung on 2020/09/23.
//  Copyright © 2020 com.doyeon. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    //아이디 번호만 넘겨주면 아이디 번호로 다시 키vs밸류 조회후 값받음 ㅎ
    
    var viewModel = DetailViewModel()
    var movieInfo = MovieDetailInfo()
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var totalViewer: UILabel!
 

    
    override func viewDidLoad() {
         super.viewDidLoad()
         updateUI()
        print("----> wpqkf... anj,,,,skdhk ...\(movieInfo.movieInfo?.actor)")
      
     }


}

extension DetailViewController {
    func updateUI(){
        let movie = viewModel.MovieInfo
        
        let url = URL(string: movie!.thumb)
        image.kf.setImage(with: url)
        movieTitle.text = movie?.title
        date.text = "\(movie?.date) 개봉"
        
          print("제목:\(MovieDetailInfo.shared.movieInfo?.title) 감독: \(MovieDetailInfo.shared.movieInfo?.audience)")
        
        print("-----> 여기당 \(MovieDetailInfo.shared.movieTitle)")
    }
}
