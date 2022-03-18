//: [Previous](@previous)

import Foundation

// A struct is a constant. So all of its properties are also constant regardless of how they were created


struct Person {
    var name: String
    
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

// Because this function changes a property,  Swift only allows that method to be called on instances that are variables(not constant)

//let person1 = Person(name: "Lucas")
//person1.makeAnonymous() // This will cause error as it changes a property inside the struct

var person = Person(name: "Chabby")
person.makeAnonymous()

//: [Next](@next)
