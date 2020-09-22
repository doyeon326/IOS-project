//
//  ParseAPI.swift
//  BoxOffice
//
//  Created by Tony Jung on 2020/09/22.
//  Copyright © 2020 com.doyeon. All rights reserved.
//

import Foundation

class ParseAPI {
    static func loadMovies(completion: @escaping ([Movie]) -> Void) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        var urlComponents = URLComponents(string: "http://connect-boxoffice.run.goorm.io/movies")!
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
}
