//: [Previous](@previous)

import Foundation

struct Person {
    private var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
        return "My social security number is \(id)"
    }
}

let lucas = Person(id: "0125")

//: [Next](@next)
