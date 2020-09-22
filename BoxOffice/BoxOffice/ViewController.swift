//
//  ViewController.swift
//  BoxOffice
//
//  Created by Tony Jung on 2020/09/21.
//  Copyright © 2020 com.doyeon. All rights reserved.
//

import UIKit

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
                }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? TableCell else {
            return UITableViewCell()
        }
        cell.title.text = "안녕"
        return cell
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


