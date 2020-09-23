//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Tony Jung on 2020/09/23.
//  Copyright © 2020 com.doyeon. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var viewModel = DetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){
        if let movieInfo = viewModel.MovieInfo {
            print("\(movieInfo.title)")
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
