//: [Previous](@previous)

import Foundation

// If you don't want to allow other developers to inherit from your class, you mark it as final
final class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

//: [Next](@next)
