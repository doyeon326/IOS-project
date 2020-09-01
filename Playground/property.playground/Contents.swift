import Cocoa

struct Person{ //Stored property
    var firstName: String{
        willSet{ //바뀐 내용
            print("willSet: \(firstName) --> \(newValue)")
        }
        didSet{ //전 값
            print("didSet: \(oldValue) --> \(firstName)") //Stored Property 에서만 사용가능
        }
    }
    var lastName: String
    
    lazy var isPopular: Bool={ // lazy property
        if fullName()   == "Jay Park"{
            return true
        }else{
            return false
        }
    }()
    
    func fullName() ->String{
        return "\(firstName) \(lastName)"
    }

//    var fullName: String{ //computed property
//            return "\(firstName) \(lastName)"
//    }
    static let isAlien : Bool = false //type property
}


var person = Person(firstName: "Jason", lastName: "Lee")
person.fullName()

 
