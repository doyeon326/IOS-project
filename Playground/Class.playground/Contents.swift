import Cocoa

struct PersonStruct{
    var firstName: String
    var lastName: String
    
    //클래스 객체 생성할때 값을 사용되는 생성 함수 -> 초기값 설정
     init(firstName: String, lastName: String){
         self.firstName = firstName
         self.lastName = lastName
     }
    
    var fullName: String{
        return "\(firstName) \(lastName)"
    }
    
    mutating func uppercaseName(){
        firstName = firstName.uppercased()
        lastName = lastName.uppercased()
    }
}

class PersonClass{
    var firstName : String
    var lastName: String
    
    //클래스 객체 생성할때 값을 사용되는 생성 함수 -> 초기값 설정
    init(firstName: String, lastName: String){
        self.firstName = firstName
        self.lastName = lastName
    }
    var fullName: String{
        return "\(firstName) \(lastName)"
    }
    func uppercaseName(){
        firstName = firstName.uppercased()
        lastName = lastName.uppercased()
    }
    
}
//왠만한 클래스와 스트럭쳐와의 구조는 같다. 하지만 쓰는 용도가 다르다.

var personStruct1 = PersonStruct(firstName: "Jason", lastName: "Lee")
var personStruct2 = personStruct1 //값복사

var personClass1 = PersonClass(firstName: "jason", lastName: "Lee")
var personClass2 = personClass1 //값참조

personStruct2.firstName = "Jay"
personStruct1.firstName
personStruct2.firstName

personClass2.firstName = "Jay"
personClass1.firstName
personClass2.firstName //클래스는 두개다 바뀜.

personClass2 = PersonClass(firstName: "Bob", lastName: "Lee")
personClass1.firstName
personClass2.firstName

personClass1 = personClass2
personClass1.firstName
personClass2.firstName //다시 참조~ 
