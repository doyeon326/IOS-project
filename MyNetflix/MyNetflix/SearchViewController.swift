//
//  SearchViewController.swift
//  MyNetflix
//
//  Created by joonwon lee on 2020/04/02.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    var movies: [Movie] = [] //mvvc패턴으로 구현하는게 낫다!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension SearchViewController: UICollectionViewDataSource {
    //몇개 넘어오니?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    //어떻게 표현할거니?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell else{
            return UICollectionViewCell()
        }
        let movie = movies[indexPath.item]
        let url = URL(string: movie.thumbnailPath)!
        //imagePath(String) -> UIimage로 변환하기
        //3rd party 가져다 쓰기!(외부코드)
        //SPM (swift project Manager) , Cocoa Pod, Carthage 외부 코드 가져올때 쓰는 방법
        cell.movieThumbnail.kf.setImage(with: url)
       // cell.movieThumbnail.image = movie.thumbnailPath
        cell.backgroundColor = .red
        return cell
    }
    
  
    
}
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //movie
        //player vc
        //player vc + movie
        //preseting player vc
        let movie = movies[indexPath.item]
        let url = URL(string: movie.previewURL)!
        let item = AVPlayerItem(url: url)
        
        
        let sb = UIStoryboard(name: "Player", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
        vc.modalPresentationStyle = .fullScreen
        
        vc.player.replaceCurrentItem(with: item)
        present(vc, animated: false, completion: nil)
        
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin: CGFloat = 8
        let itemSpacing: CGFloat = 10
        
        let width = (collectionView.bounds.width - margin * 2 - itemSpacing * 2) / 3
        let height = width * 10/7
        return CGSize(width: width, height: height)
    }
}
class ResultCell: UICollectionViewCell {
    @IBOutlet weak var movieThumbnail: UIImageView!
    
}

extension SearchViewController: UISearchBarDelegate {
    private func dismissKeyboard(){
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //검색시작
        //키보드가 올라와 있을때, 내려가게 처리
        dismissKeyboard()
        //검색어가 있는지
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return }
        
        //네트워킹을 통한 검색
        //-목표: 서치텀을 가지고 네트워킹을 통해서 영화 검색
        //-검색API가 필요
        //-결과를 받아올 모델 Movie, Response
        //- 결과를 받아와서, CollectionView를 표현해주자
        
        SearchAPI.search(searchTerm) { movies in
            // collectionView로 표현하기
            print("--> 몇개 넘어왔어?? \(movies.count), 첫번째꺼 제목: \(movies.first?.title)")
            DispatchQueue.main.async {
                 self.movies = movies
                 self.resultCollectionView.reloadData() // resultCollectionView는 UI이기 때문에 Search가 아닌 메인 스레드에서 해야할 것
            }
           
        }
        print("-->clicked \(searchTerm)")
    }
}

class SearchAPI {
    static func search(_ term: String, completion: @escaping ([Movie]) -> Void) { //search term 을 넘겨 받아서 제이슨 파싱 -> movie객체
        let session = URLSession(configuration: .default)
        
        var urlComponents = URLComponents(string: "http://itunes.apple.com/search?")!
        let mediaQuery = URLQueryItem(name: "media", value: "movie")
        let entityQuery = URLQueryItem(name: "entity", value: "movie")
        let termQuery = URLQueryItem(name: "term", value: term)
        urlComponents.queryItems?.append(mediaQuery)
        urlComponents.queryItems?.append(entityQuery)
        urlComponents.queryItems?.append(termQuery)
        
        let requestURL = urlComponents.url!
        let dataTask = session.dataTask(with: requestURL){ data, response, error in
            let successRange = 200..<300
            
            guard error == nil,
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                successRange.contains(statusCode) else {
                    completion([])
                    return
            }
            guard let resultData = data else {
                completion([])
                return
            }
          //  let string = String(data: resultData, encoding: .utf8)
            let movies = SearchAPI.parseMovies(resultData)
            completion(movies)
        }
        dataTask.resume()
        
    }
    
    static func parseMovies(_ data: Data) -> [Movie]{
        let decoder = JSONDecoder()
        do{
            let response = try decoder.decode(Response.self, from: data)
            let movies = response.movies
            return movies
        } catch let error {
            print("--> parsing error: \(error.localizedDescription)")
            return []
        }
    }
}

struct Response: Codable {
    let resultCount: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey{
        case resultCount
        case movies = "results"
    }
}

struct Movie: Codable {
    let title: String
    let director: String
    let thumbnailPath: String
    let previewURL: String
    
    enum CodingKeys: String, CodingKey{
        case title = "trackName"
        case director = "artistName"
        case thumbnailPath = "artworkUrl100"
        case previewURL = "previewUrl"
    }
}
