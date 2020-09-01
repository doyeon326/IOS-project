import Cocoa

var str = "Hello, playground"

//param 1개
//숫자를 받아서 10을 곱해서 출력한다

func printMultipleOfTen(value: Int){
    print("\(value) * 10 = \(value * 10)")
}

printMultipleOfTen(value: 5)


//func printTotalPrice(count: Int, price: Int){
//    print("Total PriceL \(price * count)")
//}

//printTotalPrice(count: 3, price: 3000)

func printTotalPrice(_ count: Int, _ price: Int){
    print("Total PriceL \(price * count)")
}

printTotalPrice(3,3000)


func printTotalPrice(가격 count: Int, 금액 price: Int){
    print("Total PriceL \(price * count)")
}

printTotalPrice(가격: 3,금액: 3000)

//default 가격 설정
func printdefaultvalueTotalPrice(가격 count: Int = 4, 금액 price: Int){
    print("Total PriceL \(price * count)")
}

printdefaultvalueTotalPrice(금액: 3000);
printdefaultvalueTotalPrice(가격:5000, 금액: 3000);

func totalPrice(price: Int, count: Int)-> Int/*반환값은 인트형*/ {
    let totalprice = price * count
    return totalprice
}

let calculatedPrice = totalPrice(price: 10000, count: 77)
print("\(calculatedPrice)")

