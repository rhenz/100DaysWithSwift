//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

struct Person {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

//: [Next](@next)
