import UIKit

var str = "countries/KR/cities/Seoul/SeoulLocation/yQ2yyLSzsoKHf6luRpH3"
let mystr = str.components(separatedBy: "/").dropLast().joined(separator: "/")

print("\(mystr)")
