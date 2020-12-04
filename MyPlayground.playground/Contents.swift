import UIKit

typealias Closure = (String, Int) -> Int


var n = 2

var number = 3
// Int값 두개를 파라미터로 받고, Int를 리턴하는 함수
var multiplyClosure = { (a: Int, b: Int) -> Int in
    return a * b
}

func multiplyFunction(a: Int, b: Int) -> Int {
    return a + b
}

multiplyClosure = multiplyFunction



var myNumber = 1

func getNumber() -> Int {
    return 3
}

myNumber = getNumber()

/// in을 써주는 조검
// 1. 파라미터가 있는 경우
// 2. Closure Capture List가 있는 경우
// 3. 두개가 동시에 있는 경우
func method(completionHandler: (Int) -> Void) {
    completionHandler(3)
}


method(completionHandler: { [myNumber] _ in
    
})


let viewController = UIViewController()
let secondViewController = UIViewController()
//1
viewController.present(secondViewController, animated: true, completion: completion)

func completion() {
    print("completion in present")
}

//2
viewController.present(secondViewController, animated: true, completion: {
    print("completion in present")
})

//3
viewController.present(viewController, animated: true) {
    print("completion in present")
}

UIView.animate(withDuration: 3, animations: {}, completion: { _ in })
