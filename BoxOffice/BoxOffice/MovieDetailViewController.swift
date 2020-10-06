//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Tony Jung on 2020/09/23.
//  Copyright © 2020 com.doyeon. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    
    @IBOutlet weak var detail: UIView!
    
    
    var viewModel = DetailViewModel()//id만 넘겨받으면 되긴함,,
    var id: String = ""
    var movieInfo: MovieInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieInfo()
       
 
    }
    
    func updateUI(){
        if let movieInfo = viewModel.MovieInfo {
            print("\(movieInfo.title)")
            print("\(id)")
        }
    }
    
    func fetchMovieInfo(){
        SearchAPI.search(id) { movie in
            DispatchQueue.main.async {
                
                self.movieInfo = movie
            
                print("----> director: \(self.movieInfo?.director), \(self.movieInfo?.audience)")
                MovieDetailInfo.shared.movieInfo = movie
                self.updateUI()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            print("prepare func")
            let vc = segue.destination as? DetailViewController
            vc?.viewModel = self.viewModel
            vc?.movieInfo.movieInfo = self.movieInfo
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("---끝나기전\(movieInfo?.actor)")
    }
}

class DetailViewModel { //싱글톤 필요!
    var MovieInfo: Movie?
    
    func update(model: Movie) {
        MovieInfo = model
    }
}


struct MovieInfo: Codable { // 클래스화해서 제이슨 파싱해서 들고있고 값뿌려줘야함 ! 
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


class MovieDetailInfo {
    static let shared: MovieDetailInfo = MovieDetailInfo()
    var movieTitle: String = ""
    var movieInfo: MovieInfo?
    var movieId : String = ""
    var actor: String = ""

    
    func updateMovieInfo(movieInfod: MovieInfo){
        print(movieInfod.actor)
        self.actor = movieInfod.actor
        self.movieInfo = movieInfod
        print(movieTitle)
    }
    func fetchActor() -> String{
        return actor
    }
    

}
