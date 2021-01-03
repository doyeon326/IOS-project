import UIKit

//URLSession

//1. URLSessionConfiguration
//2. URLSession
//3. URLSessionTask 를 이용해서 서버와 네트워킹

// URLSessionTask

// - dataTask
// - uploadTask
// - downloadTask

let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)

// URL
// URL Components

var urlComponents = URLComponents(string: "http://connect-boxoffice.run.goorm.io/movies")!
/*let mediaQuery = URLQueryItem(name: "media", value: "music")
let entityQuery = URLQueryItem(name: "entiry", value: "song")
let termQuery = URLQueryItem(name: "term", value: "지드래곤")
urlComponents.queryItems?.append(mediaQuery)
urlComponents.queryItems?.append(entityQuery)
urlComponents.queryItems?.append(termQuery)
 */
let requestURL = urlComponents.url!


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





let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
    guard error == nil else { return }
    
    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
    let successRange = 200..<300
    
    guard successRange.contains(statusCode) else {
        return
    }
    
    guard let resultData = data else { return }
    let resultString = String(data: resultData, encoding: .utf8)
 //   print("---> result: \(resultString)") //우리가 볼수 있는 형태 , resultData만 출력하면 바이트로 출력
    
 //하고싶은 목록
 //data -> track 목록으로 가져오고싶다
 //track 오브젝트를 만들어야한다
 //data에서 strict로 파싱하고 싶다 > codable 이용해서 만들자
 //json파일, 데이터 > 오브젝트 (Codable 이용한다)
 //- Responses, Track 을 만들어야한다
    
    //해야할일
    //Response, Track struct
    //struct의 프로퍼티 이름과 실제 데이터의 키와 맞추기 (Codable 디코딩하기 위해서)
    //파싱하기 (Decoding)
    //트랙리스트 가져오기
    
    //파싱 및 데이터 가져오기
       do {
        let decoder = JSONDecoder()
        let response = try decoder.decode(Response.self, from: resultData)
        let movie = response.movies
        
        print("--> tracks: \(movie.count)  -\(movie.first?.title), \(movie.last?.title)")
        
        
        
    } catch let error {
        print("---> error: \(error.localizedDescription)")
    }
    
    
}

dataTask.resume()
