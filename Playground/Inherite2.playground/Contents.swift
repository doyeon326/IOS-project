import Cocoa

struct Grade {
    var letter: Character
    var points: Double
    var credits: Double
}

class Person {
    var firstName: String
    var lastName: String

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }

    func printMyName() {
        print("My name is \(firstName) \(lastName)")
    }
}

class Student: Person {
    var grades: [Grade] = []
    
    override init(firstName: String, lastName: String){ //init이 무조건 들어가야 하나?
        super.init(firstName: firstName, lastName: lastName)
    }
    
    convenience init(student: Student){
        self.init(firstName: student.firstName, lastName: student.lastName)
    }
}

// 학생인데 운동선수
class StudentAthlete: Student {
    var minimumTrainingTime: Int = 2
    var trainedTime: Int = 0
    var sports: [String]
    
    init(firstName: String, lastName: String, sports: [String]){ //Initialization
        //phase 1
        self.sports = sports
        super.init(firstName: firstName, lastName: lastName)
        
        //phase2
        self.train() //phase1 중간에 들어가면 안된다. 모든 생성이 다 끝나야지만 가능!
    }
    convenience init(name: String){ //간략
        self.init(firstName: name, lastName: "", sports: []) //무조건 전 이닛을 불러야한다. 
    }
    
    func train() {
        trainedTime += 1
    }
}

// 운동선인데 축구선수
class FootballPlayer: StudentAthlete {
    var footballTeam = "FC Swift"

    override func train() {
        trainedTime += 2
    }
}

let student1 = Student(firstName: "Jason", lastName: "Lee")
let student2 = StudentAthlete(firstName: "Jay", lastName: "Lee", sports:["Football"])
let student3 = StudentAthlete(name: "Nike") //간략화한 init
let student1_1 = Student(student: student1)

//designated vs convenience initializer
//-> DI 는 자신의 부모의 DIf를 호출해야함
//->CI 는 같은 클래스의 이니셜라이저를 꼭 하나는 호출해야함
//-> CI는 궁극적으로 DI를 호출해야함.


