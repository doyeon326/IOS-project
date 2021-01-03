import UIKit
//higher order functions in iOS
//it's pretty brief function that do in simple way

//map filter reduce

let numbers = [1,2,3,4,3,3]

//1. filter into [3,3,3] then filter into [2,4] (even numbers)
//evven = return $0 % 2 == 0
let filtered = numbers.filter({return $0 == 3})
filtered
var filteredArray = [Int]()

for number in numbers {
    if number == 3{
        filteredArray.append(number)
    }
}
filtered
filteredArray

//2. transform [1,2,3,4] -> [2,4,6,8] using map
let transformed = [1, 2, 3, 4].map({return $0 + 3})
transformed
var transformedArray = [Int]()
for number in [1, 2, 3, 4] {
    transformedArray.append(number * 2)
}
transformedArray

//3. sum [1, 2, 3, 4] -> 10 using reduce
//let sum = [1, 2, 3, 4].reduce(0, {$0 + $1})
let sum = [1, 2, 3, 4].reduce(0,+)

sum

var sumElements = 0
for number in [1, 2, 3, 4] {
    sumElements += number
}
sumElements


//----
class Person {
    
    let name: String
    let isAdult: Bool
    
    init(name: String, isAdult: Bool) {
        self.name = name
        self.isAdult = isAdult
    }
}
var array = [
    Person(name: "john", isAdult: true),
    Person(name: "jessica", isAdult: true),
    Person(name: "annie", isAdult: false),
    Person(name: "iris", isAdult: true),
    Person(name: "valerie", isAdult: false),
    Person(name: "chris", isAdult: true),
    Person(name: "christine", isAdult: false)
]
print("Before \(array)")

array = array.filter({ return $0.isAdult})
let nameOfAdults = array.map({ $0.name})

print("\(nameOfAdults)")
