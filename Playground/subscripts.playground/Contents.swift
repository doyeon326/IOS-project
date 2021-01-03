import UIKit

struct Broadcast{
    var stations = [
    ["KBS","SBS","MBC"],
    ["JTBC","TVN","EBS"],
    ["CCN","OCN","BBC"],
    ]
    
    subscript(row: Int, col: Int) -> String {
        get{
            return stations[row][col]
        }
        set{
            stations[row][col] = newValue
        }
        
        
       // return stations[row][col]
        //not only returning the value
        //you can also modify the value
        
        
    }
}

var broadcast = Broadcast() //object of struct
broadcast.stations[1][1]
broadcast[1,1]
broadcast[0,0] = "BBC"
