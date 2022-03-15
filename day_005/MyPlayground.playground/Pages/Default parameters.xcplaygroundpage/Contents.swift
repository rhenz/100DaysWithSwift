//: [Previous](@previous)

import Foundation

func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)")
    } else {
        print("Oh no, it's \(person) again!")
    }
}

greet("Lucas")
greet("Chabby", nicely: false)

//: [Next](@next)
