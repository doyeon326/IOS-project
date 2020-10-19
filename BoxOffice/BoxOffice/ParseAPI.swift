import Foundation

class ParseAPI {
    static func loadMovies(_ typeStatus: Int, completion: @escaping ([Movie]) -> Void) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
    
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
}

class SearchAPI {
    static func search(_ id: String, completion: @escaping (MovieInfo) -> Void) {
        print("\(id) is successfully in")
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

class RequestComments {
    static func requestComments(_ id: String, completion: @escaping ([Comments]) -> Void) {
        print("-->Movie id: \(id)")
        let session = URLSession(configuration: .default)
        var urlComponents = URLComponents(string: "http://connect-boxoffice.run.goorm.io/comments?")!
        let idQuery = URLQueryItem(name: "movie_id", value: id)
        urlComponents.queryItems?.append(idQuery)
        
        let requestURL = urlComponents.url!
        let dataTask = session.dataTask(with: requestURL){ data, Response, error in
            let successRange = 200..<300
            
            guard error == nil,
                let statusCode = (Response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else{
                    return
            }
            guard let resultData = data else {
                return
            }
            let comments = RequestComments.parseComments(resultData)
            completion(comments)
            
        }
        dataTask.resume()
    }
    
    static func parseComments(_ data: Data) -> [Comments] {
        let decoder = JSONDecoder()
        do{
            let response = try decoder.decode(MovieComments.self, from: data)
            let comments = response.comments
            return comments
        }catch let error {
            print("---> parsing error: \(error.localizedDescription)")
            return[]
        }
    }
}

func requestComment(comment: Comment){
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    guard let url: URL = URL(string: "http://connect-boxoffice.run.goorm.io/comment") else { return }
    var request = URLRequest(url: url)
        request.httpMethod = "POST"
    
    let jsonEncode = JSONEncoder()
    do {
        let data: Data = try jsonEncode.encode(comment)
        request.httpBody = data
    } catch (let error) {
        print(error.localizedDescription)
    }
    let dataTask: URLSessionDataTask = session.dataTask(with: request) {
        (data, response, error) in
        guard error == nil else { return }
        
        guard let resultData = data else { return }
        do{
            let jsonDecoder: JSONDecoder = JSONDecoder()
            let commentResponse: Comment = try jsonDecoder.decode(Comment.self, from:data!)
        }catch(let error){
            print(error.localizedDescription)
        }
        
    }
    dataTask.resume()
}
