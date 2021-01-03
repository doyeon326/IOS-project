import UIKit

// Queue - Main, Global, Custom


//// Main
//DispatchQueue.main.sync {
//    let view = UIView()
//    view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//}
// Global
DispatchQueue.global(qos: .userInteractive).async {
    //핵중요, 지금 당장 해야하는 것
}

DispatchQueue.global(qos: .userInitiated).async {
    //거의 바로 해줘야하는 것, 사용자가 결과를 기다린다
}

DispatchQueue.global(qos: .default).async {
    //굳이?
}

DispatchQueue.global(qos: .utility).async {
    //시간이 좀 걸리는 일들, 사용자가 기다리지 않는것, 네트워킹, 큰파일 불러올때
}

DispatchQueue.global(qos: .background).async {
    //사용자한테 당장 인식할 필요가 없는것들, 뉴스데이터 미리받기, 위치 업데이트, 영상 다운받는 ,,
}

//Custom queue
let concurrentQueue = DispatchQueue(label: "concurrent", qos: .background, attributes: .concurrent)
let serialQueue = DispatchQueue(label: "serial", qos: .background)

//복잡한 상황
func downloadImageFromServer() -> UIImage {
    return UIImage()
}

func updateUI(image: UIImage) {
    
}

DispatchQueue.global(qos: .background).async {
    let image = downloadImageFromServer()
    
     DispatchQueue.main.async { //이미지 관련은 무조건 메인에서
        updateUI(image: image)
    }
}

//Sync, Async
//sync = 무조건 끝나기 전까진 다음게 실행이 안됨.
DispatchQueue.global(qos: .background).async {
    for i in 0...5{
        print("⚽️\(i)")
    }
}

DispatchQueue.global(qos: .userInteractive).sync {
    for i in 0...5{
        print("🏈\(i)")
    }
}
