import UIKit

// --> Sorting

let scores = [80, 90, 75, 99]

let sortedScores = scores.sorted()
sortedScores

scores.sorted { a, b -> Bool in
    return a > b
}


// --> Filtering

let prices = [1500, 30000, 2000, 20000]

let expensivePrices = prices.filter { price -> Bool in
    return price > 10000
}


// --> Map
// 재가공

let discountedPrices = prices.map { price -> Int in
    return Int(Double(price) * 0.1)
}



// --> Reduce
// 컬렉션에 있는 애들의 값을 한가지로 만드려고 할때

let sum = prices.reduce(0) { (중간결과물, price) -> Int in
    return 중간결과물 + price
}


let items = [1500: 5, 30000: 1, 2000: 3, 20000: 2]

let totalPrice = items.reduce(0) { result, item -> Int in
    return result + item.key * item.value
}

1500 * 5 + 30000 * 1 + 2000 * 3 + 20000 * 2





// 1. 이름의 Array를 생성하고, reduce를 이용해서 모든 이름 연결하기
// 2. 1에서 생성된 이름의 Array에서 글자가 3개 초과인 이름을 filter로 걸러내고, 걸러낸 이름을 reduce를 이용해서 연결하기
// 3. 학생들 딕셔너리 만들기 (키: 이름, 밸류: 나이), filter를 이용해서 20세 이상인 학생만 걸러내기
// 4. 3번에서 걸러낸 학생들... map을 이용해서 이름만 Array만들기


let names = ["Jason", "Jim", "James", "Jake", "Jay"]

let allNames = names.reduce("") { result, name -> String in
    return result + " " + name
}


//let filteredNames = names.filter { name -> Bool in
//    return name.count > 3
//}
//
//let allNames2 = filteredNames.reduce("") { (result, name) -> String in
//    return result + " " + name
//}


//let filteredNames = names.filter { name -> Bool in
//    return name.count > 3
//}

let allNames2 = names
                    .filter { name -> Bool in
                        return name.count > 3
                    }.reduce("") { (result, name) -> String in
                        return result + " " + name
                    }




let students = ["Jason": 15, "Jim": 35, "James": 24, "Jake": 18, "Jay": 41]


let adultStudents = students.filter { student -> Bool in
    return student.value > 20
}

let adultStudentNames = adultStudents.map { (student) -> String in
    return student.key
}
















