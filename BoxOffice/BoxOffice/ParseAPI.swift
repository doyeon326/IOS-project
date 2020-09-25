//
//  ParseAPI.swift
//  BoxOffice
//
//  Created by Tony Jung on 2020/09/22.
//  Copyright © 2020 com.doyeon. All rights reserved.
//

import Foundation

class ParseAPI {
    static func loadMovies(_ typeStatus: Int, completion: @escaping ([Movie]) -> Void) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        print("--->movie type: \(typeStatus)")
        var str = "http://connect-boxoffice.run.goorm.io/movies?order_type=\(typeStatus)"
        var urlComponents = URLComponents(string: str)!
        let requestURL = urlComponents.url!
        
       let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
                guard error == nil else { return }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            let successRange = 200..<300
            
            guard successRange.contains(statusCode) else {
                return
            }
            guard let resultData = data else{
                completion([])
                return
            }
            let movies = ParseAPI.parseMovies(resultData)
            print("success!")
            completion(movies)
        }
        dataTask.resume()
    }
    
    static func parseMovies(_ data: Data) -> [Movie] {
        
        do{
            let decoder = JSONDecoder()
            let response = try decoder.decode(Response.self, from: data)
            let movie = response.movies
            return movie
        }catch let error{
            print("--> parsing error: \(error.localizedDescription)")
            return []
        }
    }
    
    //SearchMoviesAPI도 만들어야함
}

class SearchAPI {
    static func search(_ id: String, completion: @escaping (MovieInfo) -> Void) {
        let session = URLSession(configuration: .default)
        var urlComponents = URLComponents(string: "http://connect-boxoffice.run.goorm.io/movie?")!
        let idQuery = URLQueryItem(name: "id", value: id)
        urlComponents.queryItems?.append(idQuery)
        
        let requestURL = urlComponents.url!
        let dataTask = session.dataTask(with: requestURL){ data, Response, error in
            let successRange = 200..<300
            
            guard error == nil,
                let statusCode = (Response as? HTTPURLResponse)?.statusCode,
                successRange.contains(statusCode) else {
                    return
            }
            guard let resultData = data else {
                return
            }
            let movieInfo = SearchAPI.parseMovieInfo(resultData)
            completion(movieInfo!)
            
        }
        dataTask.resume()
    }
    
    static func parseMovieInfo(_ data: Data) -> MovieInfo? {
        let decoder = JSONDecoder()
     //   var movieInfo: MovieInfo
        do{
            let response = try decoder.decode(MovieInfo.self, from: data)
            let movieInfo = response
            return movieInfo
        } catch let error {
            print("---> \(error.localizedDescription)")
            return nil
        }
    }
}
