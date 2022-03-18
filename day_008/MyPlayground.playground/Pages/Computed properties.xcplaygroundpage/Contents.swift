//: [Previous](@previous)

import Foundation

struct Sport {
    var name: String // Stored property
    
    var isOlympicSport: Bool
    
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic Sport"
        } else {
            return "\(name) is not an Olympic Sport"
        }
    }
}

let chessBoxing = Sport(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)

//: [Next](@next)
