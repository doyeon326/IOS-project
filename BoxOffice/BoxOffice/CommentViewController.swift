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
            self.rating.text = "\(rating * 2)"
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendRequest(_ sender: Any) {
        var comment = Comment(rating: currentStar, writer: commentTitle.text!, movie_id: MovieDetailInfo.shared.movieId, contents: commentTxt.text)
 
        requestComment(comment: comment)
        print("completed")
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
