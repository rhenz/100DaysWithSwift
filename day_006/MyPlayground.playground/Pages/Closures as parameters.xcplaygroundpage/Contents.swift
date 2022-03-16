//: [Previous](@previous)

import Foundation

let driving = {
    print("I'm driving in my car")
}

func travel(action: () -> Void) {
    print("I'm ready to go.")
    action()
    print("I arrived")
}

travel(action: driving)

//: [Next](@next)
