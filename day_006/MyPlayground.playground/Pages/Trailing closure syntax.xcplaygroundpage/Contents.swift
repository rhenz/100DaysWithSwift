//: [Previous](@previous)

import Foundation

func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel {
    print("I'm driving in my car")
}

//: [Next](@next)
