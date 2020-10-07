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
    //테이블뷰로 바꿔야함
    //고민해봐야할것. 1. 컨텐츠의 따른 셀크기
    var movieInfo = MovieDetailInfo()
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var totalViewer: UILabel!

    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var director: UILabel!
    
    override func viewDidLoad() {
         super.viewDidLoad()

     }

    override func viewDidAppear(_ animated: Bool) {
        fetchMovieInfo()
    }
    
    func fetchMovieInfo(){
        SearchAPI.search(MovieDetailInfo.shared.movieId) { movie in
                   DispatchQueue.main.async {
                    self.movieInfo.movieInfo = movie
                    self.updateUI()
                    self.view.setNeedsLayout()
                   }
        }
    }
}

extension DetailViewController {
    func updateUI(){
        let movie = movieInfo.movieInfo!
        
        let url = URL(string: movie.image)
        image.kf.setImage(with: url)
        movieTitle.text = movie.title
        date.text = "\(movie.date)개봉"
        duration.text = "\(movie.genre)/\(movie.duration)분"
        totalViewer.text = "\(movie.audience)"
        rate.text = "\(movie.userRating)"
        rank.text = "\(movie.reservationGrade)위 \(movie.reservationRate)%"
        summary.text = movie.synopsis
        director.text = "\(movie.actor)/\(movie.director)"
    }
    
    
}
