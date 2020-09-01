import UIKit


var multiplyClosure: (Int, Int) -> Int = { a, b in
    return a * b
}

let result = multiplyClosure(4, 2)



func operateTwoNum(a: Int, b: Int, opertion: (Int, Int) -> Int) -> Int {
    let result = opertion(a, b)
    return result
}


operateTwoNum(a: 4, b: 2, opertion: multiplyClosure)

var addClosure: (Int, Int) -> Int = { a, b in
    return a + b
}
operateTwoNum(a: 4, b: 2, opertion: addClosure)


operateTwoNum(a: 4, b: 2) { a, b in
    return a / b
}

// codeForEveryoneJoonwon+02@gmail.com

let voidClosure: () -> Void = {
    print("iOS 개발자 짱, 클로져 사랑해")
}

voidClosure()



// Capturing Values

var count = 0

let incrementer = {
    count += 1
}

incrementer()
incrementer()
incrementer()
incrementer()

count
