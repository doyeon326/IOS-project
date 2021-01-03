import UIKit

struct Device {
    var model: String
    var price: Double
}

class macOS {
    var releaseDate: String
    var origin: String
    
    init(origin: String, releaseDate:String) {
        self.origin = origin
        self.releaseDate = releaseDate
    }
    
    func description() {
       print("##made in \(origin) in \(releaseDate)")
    }
}

class Iphone: macOS {
    var device: [Device] = []
}

let oldPhone = Iphone(origin: "China", releaseDate: "2018")
let newPhone = macOS(origin: "USA", releaseDate: "2020")

oldPhone.description()
newPhone.description()

let device = Device(model: "iphone8", price: 1000)

oldPhone.device.append(device)
oldPhone.device.count

class Person: Iphone {
    var timeUsage: Int = 0
    
    func screenUsed(){
        timeUsage += 1
    }
}

class Student: Person {
    var age = 16
    
    override func screenUsed() {
        timeUsage += 3
    }
}


var Angela = Person(origin: "China", releaseDate: "2008")
var Jessica = Student(origin: "USA", releaseDate: "2020")

//Angela.device.append(device)
Angela.timeUsage
Angela.screenUsed()
Angela.timeUsage


//Jessica.device.append(device)
Jessica.timeUsage
Jessica.screenUsed()
Jessica.timeUsage




//upperCasting
Angela = Jessica as Person
Angela.screenUsed()
Angela.timeUsage

     
//downcasting
if let doyeon = Angela as? Student{
    print("--> \(doyeon.age)")
}
print(Angela is Student)
