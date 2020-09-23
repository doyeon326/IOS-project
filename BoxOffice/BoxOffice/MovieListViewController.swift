//
//  MovieListViewController.swift
//  BoxOffice
//
//  Created by Tony Jung on 2020/09/22.
//  Copyright © 2020 com.doyeon. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListViewController: UIViewController {

    var movies: [Movie] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ParseAPI.loadMovies { movies in
             print("몇개? \(movies.count), 첫번째 제목 \(movies.first?.title)")
            DispatchQueue.main.async {
                            self.movies = movies
                            self.collectionView.reloadData()
                        }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? MovieDetailViewController
        if let indexPath = self.collectionView.indexPathsForSelectedItems {
            let movieInfo = movies[indexPath.first!.item]
                  vc?.viewModel.update(model: movieInfo)
              }
      }
}


extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        let movie = movies[indexPath.item]
        let url = URL(string: movie.thumb)!
        cell.image.kf.setImage(with: url)
        cell.date.text = movie.date
        cell.rank.text = "\(movie.reservationGrade)위(\(movie.userRating))/ \(movie.reservationRate)%"
        cell.title.text = movie.title
        return cell
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //눌렀을때
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
               let itemSpacing: CGFloat = 10
               let textAreaHeight: CGFloat = 65
               let width: CGFloat = (collectionView.bounds.width - itemSpacing)/2
               let height: CGFloat = width * 10/7 + textAreaHeight
               return CGSize(width: width, height: height)
    }
}

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image: UIImageView!
}
