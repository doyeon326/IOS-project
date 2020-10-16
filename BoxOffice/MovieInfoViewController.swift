//
//  MovieInfoViewController.swift
//  BoxOffice
//
//  Created by Tony Jung on 2020/10/08.
//  Copyright © 2020 com.doyeon. All rights reserved.
//

import UIKit
import Kingfisher

class MovieInfoViewController: UIViewController {

    var movieInfo = MovieDetailInfo()
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    var tableviewHeight: CGFloat = 30
    var comments: [Comments] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var userRating: UILabel!
    @IBOutlet weak var reservationRate: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var totalViewer: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var actors: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension

    }
    
    override func viewDidAppear(_ animated: Bool) {
         fetchMovieInfo()
         fetchComments()
      
     }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(cell.frame.size.height, self.tableViewHeight)
        self.tableviewHeight += cell.frame.size.height
        tableViewHeight.constant = tableviewHeight
        tableView.layoutIfNeeded()
    }
    
     func fetchMovieInfo(){
         SearchAPI.search(MovieDetailInfo.shared.movieId) { movie in
                    DispatchQueue.main.async {
                     self.movieInfo.movieInfo = movie
                    //    print(movie.synopsis)
                     self.updateUI()
                     self.view.setNeedsLayout()
                    }
         }
     }
    
    func fetchComments(){
        RequestComments.requestComments(MovieDetailInfo.shared.movieId) { comments in
            DispatchQueue.main.async {
               //print("\(comments.first?.contents)")
                self.comments = comments
          
                self.tableView.reloadData()
            }
        }
    }
    func updateUI(){
        let movie = movieInfo.movieInfo!
        
        let url = URL(string: movie.image)
        img.kf.setImage(with: url)
        movieTitle.text = movie.title
        releaseDate.text = "\(movie.date)개봉"
        duration.text = "\(movie.genre)/\(movie.duration)분"
        totalViewer.text = "\(movie.audience)"
        userRating.text = "\(movie.userRating)"
        reservationRate.text = "\(movie.reservationGrade)위 \(movie.reservationRate)%"
        summary.text = movie.synopsis
        actors.text = "\(movie.actor)/\(movie.director)"
    }
}
extension MovieInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as? CommentsCell else {
            return UITableViewCell()
        }
        let comments = self.comments[indexPath.row]
        cell.comments.text = "\(comments.contents)"
        cell.date.text = "\(comments.timestamp)"
        cell.rating.text = "\(comments.rating)"
        cell.userName.text = "\(comments.writer)"
        return cell
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
struct MovieComments:Codable {
   let comments: [Comments]
}
struct Comments:Codable{
    let rating: Double
    let movie_id: String
    let writer: String
    let timestamp: Double
    let id: String
    let contents: String
}

class MovieDetailInfo {
    static let shared: MovieDetailInfo = MovieDetailInfo()
    var movieInfo: MovieInfo?
    var movieId : String = ""

}

class CommentsCell: UITableViewCell {
    
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var userName: UILabel!
}
