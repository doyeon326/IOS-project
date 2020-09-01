import Cocoa

//방법1
var scoreDic : [String: Int] = ["Jason": 80, "Jay": 95, "Jake": 98]
//방법2
var scoreDic2 : Dictionary<String,Int> = ["Jason": 80, "Jay": 95, "Jake": 98]

scoreDic["Jason"]
scoreDic["Jay"]
scoreDic["Jerry"] // 값이 없음 = nil 즉, optional so.. use optional binding

if let score = scoreDic["Jason"]{
    score
}else{
    print("없음")
}

//scoreDic = [:] //깡통 초기화
//공통 property isEmpty & count
scoreDic.isEmpty
scoreDic.count

//값 업데이트
scoreDic["Jason"] = 99

//값 추가
scoreDic["Jack"] = 100
//값 제거
scoreDic["Jack"] = nil

scoreDic

//for Loop
for (name, score) in scoreDic{
    print("\(name), \(score)")
}

// 키만 뽑아내기, 순서는 x
for key in scoreDic.keys{
    print(key) //키만 가져오기
}

//1. 도전과제 이름 직업 도시 에대해서 본인의 딕셔너리 만들기
//2. 도시를 부산으로 업데이트 하기
//3. 이름과 도시 출력

var myCity : [String: String] = ["이름" : "김도연", "직업" : "무직", "도시": "서울"]
myCity["도시"] = "부산"

//for (name, city) in myCity{
//    print("\(name), \(city)")
//}

func printNameAndCity(dic: [String: String]){
    if let name = dic["이름"], let city = dic["도시"]{
        print(name,city)
    }else{
        print("없음")
    }
}

printNameAndCity(dic: myCity)
