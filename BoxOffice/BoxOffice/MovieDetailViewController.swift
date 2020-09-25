//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Tony Jung on 2020/09/23.
//  Copyright © 2020 com.doyeon. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var viewModel = DetailViewModel()//id만 넘겨받으면 되긴함,,
    var id: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){
        if let movieInfo = viewModel.MovieInfo {
            print("\(movieInfo.title)")
            print("\(id)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let vc = segue.destination as? DetailViewController
            vc?.viewModel = self.viewModel
        }
        
    }
}

class DetailViewModel { //싱글톤 필요!
    var MovieInfo: Movie?
    
    func update(model: Movie) {
        MovieInfo = model
    }
}

struct MovieInfo: Codable { // 클래스화해서 제이슨 파싱해서 들고있고 값뿌려줘야함 
    let image: String
    let duration: Int
    let date: String
    let reservationRate : Double
    let grade : Int
    let director: String
    let audience: Int
    let reservationGrade: Int
    let actor: String
    let userRating: Double
    let genre: String
    let synopsis: String
    let id: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
            case image
            case duration
            case date
            case reservationRate = "reservation_rate"
            case grade
            case director
            case audience
            case reservationGrade = "reservation_grade"
            case actor
            case userRating = "user_rating"
            case genre
            case synopsis
            case id
            case title
    }
}
