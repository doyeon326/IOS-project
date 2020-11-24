import UIKit

struct Employee {
    var name: String
}

extension Employee {
    init() {
        self.name = "Anonymous"
    }
}

// creating a named employee now works
let roslin = Employee(name: "Laura Roslin")
roslin.name //"Laura Roslin"
// as does creating an anonymous employee
let anon = Employee()
anon.name //"Anonymous"
