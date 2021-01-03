import UIKit

let urlString = "https://itunes.apple.com/search?media=muaic&entity=song&term=Gdragon"
let url = URL(string: urlString)

url?.absoluteString
url?.scheme //https (s = secure)
url?.host
url?.path
url?.query
url?.baseURL

//baseURL나오게 설정
let baseURL = URL(string: "https://itunes.apple.com")
let relativeURL = URL(string: "search?media=music&entity=song&term=Gdragon", relativeTo: baseURL)

relativeURL?.absoluteString //"https://itunes.apple.com/search?media=music&entity=song&term=Gdragon"
relativeURL?.scheme //"https"
relativeURL?.host //"itunes.apple.com"
relativeURL?.path //"/search"
relativeURL?.query //"media=music&entity=song&term=Gdragon"
relativeURL?.baseURL //https://itunes.apple.com

//URLcomponent = encoding을 해줘야한다! (한국말이나, 다른 언어를 사용할때)
var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")
let mediaQuery = URLQueryItem(name: "media", value: "music")
let entityQuery = URLQueryItem(name: "entity", value: "song")
let termQuery = URLQueryItem(name: "term", value: "지드래곤")

urlComponents?.queryItems?.append(mediaQuery)
urlComponents?.queryItems?.append(entityQuery)
urlComponents?.queryItems?.append(termQuery)

urlComponents?.url //https://itunes.apple.com/search?media=music&entity=song&term=%EC%A7%80%EB%93%9C%EB%9E%98%EA%B3%A4
urlComponents?.string
urlComponents?.queryItems?.last?.value //"지드래곤"
urlComponents?.queryItems //[{name "media", value "music"}, {name "entity", value "song"}, {name "term", value "지드래곤"}]
