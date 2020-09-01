import Cocoa

//overrode
//함수의 이름은 같지만 다양한 리턴을 줄 경우

func printTotalPrice(price: Int, count: Int){
    print("Total price: \(price * count)")
}

func printTotalPrice(price: Double, count: Double){
    print("Total price: \(price * count)")
}

func printTotalPrice(가격: Double, 갯수: Double){
    print("Total price: \(가격 * 갯수)")
}

//In-out parameter

//func incrementAndPrint(_ value: Int){
//    value += 1
//    print(value)
//} //스위프트에서는 이렇게 파라미터로 값을 받았을때 그 값을 변경을 할수가 없다. 그래서 값을 더할수가 없는거다.
//이럴때 사용해야하는게 In-out 이다.

var value = 3
func incrementAndPrint(_ value: inout Int){ //그래서 여기에다가 inout을 적어주면 된다.
    value += 1
    print(value)
}
incrementAndPrint(&value)  //그리고 '&' 를 붙여줘야하는듯.. 매개변수일땐 무조건붙여줘야한다~


//함수를 파라미터로 넘기는법 :

func add(_ a: Int, _ b: Int)-> Int{
    return a + b
}
func substract(_ a: Int, _ b: Int)-> Int{
    return a - b
}

//스위프트에다간 변수에 함수를 할당할수가 있다.
var function = add //add라는 함수를 할당함!
function(4,2)
function = substract
function(4,2)

func printResult(_ function: (Int, Int) -> Int, _ a: Int, _ b: Int){ //함수를 받을수가 있다. 0_0
    let result = function(a, b) //함수에다가 함수를 넘기는,,,!!!! 근데 함수 타입이 같아야한다~는걸 명심!
    print(result)
}

printResult(add, 10, 5)
printResult(substract, 10, 4)
