//
//  ParseAPI.swift
//  BoxOffice
//
//  Created by Tony Jung on 2020/09/22.
//  Copyright © 2020 com.doyeon. All rights reserved.
//

import Foundation

class ParseAPI {
    static func loadMovies(_ typeStatus: Int, completion: @escaping ([Movie]) -> Void) { //default인지, 순으로 받아야함, //update를 하고 fetch 로 받아야함
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
      //  let movieType = MovieType()
       // var type = movieType.fetchType()
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
       //     print("--> tracks: \(movie.count)  -\(movie.first?.title), \(movie.last?.title)")
            return movie
            
        }catch let error{
            print("--> parsing error: \(error.localizedDescription)")
            return []
        }
    }
    
    //SearchMoviesAPI도 만들어야함
}

