//
//  ViewController.swift
//  BoxOffice
//
//  Created by Tony Jung on 2020/09/21.
//  Copyright © 2020 com.doyeon. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ParseAPI.loadMovies { movies in
                print("몇개? \(movies.count), 첫번째 제목 \(movies.first?.title)")
                DispatchQueue.main.async {
                    self.movies = movies
                    self.tableView.reloadData()
                }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "movieDetail" {
            //모델 넘기기 
            let vc = segue.destination as? MovieDetailViewController
            if let index = self.tableView.indexPathForSelectedRow as? Int {
                let movieInfo = movies[index]
                vc?.movietitle.text = movieInfo.title
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? TableCell else {
            return UITableViewCell()
        }
        let movie = movies[indexPath.item]
        let url = URL(string: movie.thumb)!
        
        cell.movieImage.kf.setImage(with: url)
        cell.title.text = movies[indexPath.row].title
        cell.date.text = "개봉일: \(movies[indexPath.row].date)"
        cell.detail.text = "평점: \(movies[indexPath.row].userRating) 예매순위: \(movies[indexPath.row].reservationGrade) 예매율: \(movies[indexPath.row].reservationRate)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print("--->\(indexPath.row)")
       // performSegue(withIdentifier:"movieDetail", sender: indexPath.row)
    }
}

class TableCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var title: UILabel!
    //circle & label color need to be change
}

struct Response: Codable {
    let movies: [Movie]
}

struct Movie: Codable {
    let date: String
    let title: String
    let userRating: Double
    let reservationRate: Double
    let thumb: String
    let reservationGrade: Int
    
    enum CodingKeys: String, CodingKey{
        case date
        case title
        case userRating = "user_rating"
        case reservationRate = "reservation_rate"
        case thumb
        case reservationGrade = "reservation_grade"
    }
    
    
}

class DetailViewModel {
    var MovieInfo: Movie?
    
    func update(model: Movie) {
        MovieInfo = model
    }
}
