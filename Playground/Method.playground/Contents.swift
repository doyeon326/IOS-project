import Cocoa

struct Lecture{
    var title: String
    var maxStudent: Int = 10
    var numOfRegistered: Int = 0
    
    func remainSeats() -> Int{
        let remainSeats = maxStudent - numOfRegistered
        return remainSeats
    }
    
    mutating func register(){ //값을 변경 시키기 때문에 mutating 을 적어야한다.
        //등록된 학생수 증감시키기
        numOfRegistered += 1
    }
    
    static let target: String = "Anybody want to learn something" //type property
    
    static func 소속학원이름() ->  String { //type method
        return "패캠"
    }
}

var lec = Lecture(title: "iOS Basic")
lec.remainSeats()

lec.register()
lec.remainSeats()

Lecture.target
Lecture.소속학원이름()

struct Math{
    static func abs(value: Int) -> Int{
        if value>0{
            return value
        }else{
            return -value
        }
        
    }
}

Math.abs(value: -20)

extension Math{ //확장하겠다. . 외부 새로운 메서드를 정의하는것도 가능.
    static func square(value: Int)-> Int{
        return value * value
    }
    
    static func half(value: Int) -> Int{
        return value/2
    }
    
}
Math.square(value: 5)
Math.half(value: 5)

var value: Int = 3

extension Int{
    func square() -> Int{
        return self * self
    }
    func half() -> Int{
        return self/2
    }
}

value.square()
value.half()
