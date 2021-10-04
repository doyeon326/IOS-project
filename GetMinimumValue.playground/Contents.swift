import UIKit


var x = [1,2,3,4,5,6,7,8,9,10]
var min = x[0]
var max = x[0]

for i in 0..<x.count {
    if x[i] > max {
        max = x[i]
    }
    if min > x[i] {
        min = x[i]
    }
}

print("MAX: \(max), MIN: \(min)")
