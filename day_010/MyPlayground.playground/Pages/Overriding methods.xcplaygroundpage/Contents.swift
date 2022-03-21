//: [Previous](@previous)

import Foundation

class Dog {
    func makeNoise() {
        print("Woof!")
    }
}

class Poodle: Dog {
    
    // This is how we can override methods of superclass method
    override func makeNoise() {
        print("Arf!")
    }
}

let hachi = Poodle()
hachi.makeNoise()

//: [Next](@next)
