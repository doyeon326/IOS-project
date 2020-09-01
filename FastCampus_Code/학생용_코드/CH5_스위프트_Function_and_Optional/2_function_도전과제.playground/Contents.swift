import UIKit


// Overload

//func functionName(externalName param: ParamType) -> ReturnType {
//    return returnValue
//}

func printTotalPrice(price: Int, count: Int) {
    print(" Total Price: \(price * count)")
}

func printTotalPrice(price: Double, count: Double) {
    print(" Total Price: \(price * count)")
}


func printTotalPrice(가격: Int, 개수: Int) {
    print(" 총 가격은 \(가격 * 개수)")
}


// In-out paramter


var value = 3

func incrementAndPrint(_ value: inout Int) {
    value += 1
    print(value)
}

incrementAndPrint(&value)
