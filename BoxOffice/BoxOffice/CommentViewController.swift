//
//  CommentViewController.swift
//  BoxOffice
//
//  Created by Tony Jung on 2020/10/19.
//  Copyright © 2020 com.doyeon. All rights reserved.
//

import UIKit
import Cosmos

class CommentViewController: UIViewController {

    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGrade: UIImageView!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var rating: UILabel!

    @IBOutlet weak var commentTitle: UITextField!
    @IBOutlet weak var commentTxt: UITextView!
    var currentStar: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commentTxt.layer.borderWidth = 1.0
        self.commentTxt.layer.cornerRadius = 5
        
        cosmosView.didFinishTouchingCosmos = { rating in
            print(rating)
            self.currentStar = rating * 2
        }
        cosmosView.didTouchCosmos = { rating in
            self.rating.text = "\(Int(rating * 2))"
        }
        movieTitle.text = MovieDetailInfo.shared.movieInfo?.title
        let grade = MovieDetailInfo.shared.movieInfo?.grade
        switch grade {
        case 12: movieGrade.image = UIImage(named: "ic_12")
        case 15: movieGrade.image = UIImage(named: "ic_15")
        case 19: movieGrade.image = UIImage(named: "ic_19")
        default:
            movieGrade.image = UIImage(named: "ic_allages")
        }
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendRequest(_ sender: Any) {
        var comment = Comment(rating: currentStar, writer: commentTitle.text!, movie_id: MovieDetailInfo.shared.movieId, contents: commentTxt.text)
        requestComment(comment: comment)
        print("completed")
        navigationController?.popViewController(animated: true)
    }
}
struct Comment: Codable {
    var rating : Double
    let writer: String
    let movie_id: String
    let contents: String
    
    init(rating: Double, writer: String, movie_id: String, contents: String) {
        self.rating = rating
        self.writer = writer
        self.movie_id = movie_id
        self.contents = contents
    }
}
