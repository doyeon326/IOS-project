import UIKit

var carName: String?
carName = nil
carName = "땡크"


// 아주 간단한 과제
// 1. 여러분이 최애하는 영화배우의 이름을 담는 변수를 작성해주세요 (타입 String?)
// 2. let num = Int("10") -> 타입은 뭘까요??

var favoriteMovieStar: String? = nil
let num = Int("10")


// 고급 기능 4가지

// Forced unwrapping
// Optional binding (if let)
// Optional binding (guard)
// Nil coalescing

// Forced unwrapping > 억지로 박스를 까보기
// Optional binding (if let) > 부드럽게 박스를 까보자 1
// Optional binding (guard) > 부드럽게 박스를 까보자 2
// Nil coalescing > 박스를 까봤더니, 값이 없으면 디폴트 값을 줘보자

carName = nil
//print(carName!)

if let unwrappedCarName = carName {
    print(unwrappedCarName)
} else {
    print("Car Name 없다")
}



//여행 계획표
//- 싱가폴
//- 싱가폴 맛집
//- 싱가폴 숙소
//
//
//
//여행 계획표
//- 싱가폴
//    - ㅇㅇㅇㅇ
//    - ㅇㅇ누구 만나고
//        - 친구 누구도 부르고
//- 싱가폴 맛집
//- 싱가폴 숙소



//func printParsedInt(from: String) {
//    if let parsedInt = Int(from) {
//        print(parsedInt)
//    } else {
//        print("Int로 컨버팅 안된다 짜샤. ")
//    }
//}

//printParsedInt(from: "100")
//printParsedInt(from: "헬로우 마이네임이즈")


func printParsedInt(from: String) {
    guard let parsedInt = Int(from) else {
        print("Int로 컨버팅 안된다 짜샤. ")
        return
    }
    
    print(parsedInt)
}

//printParsedInt(from: "100")
printParsedInt(from: "헬로우 마이네임이즈")


carName = "모델 3"
let myCarName: String = carName ?? "모델 S"




// --- 도전 과제
// 1. 최애 음식이름을 담는 변수를 작성하시고 (String?) ,
// 2. 옵셔널 바인딩을 이용해서 값을 확인해보기
// 3. 닉네임을 받아서 출력하는 함수 만들기, 조건 입력 파라미터는 String?


let favoriteFood: String? = "양고기"

if let foodName = favoriteFood {
    print(foodName)
} else {
    print("좋아하는 음식 없음")
}



func printNickName(name: String?) {
    guard let nickName = name else {
        print("nickname 만들어 보자")
        return
    }
    
    print(nickName)
}


printNickName(name: nil)

