//: [Previous](@previous)

import Foundation

func travel() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

let result = travel() // This returns a closure of { print("I'm going...) }
result("London") // Now you can use the result variable like a function/closure


let result2 = travel()("London") // This is allowed, but not recommended. Might cause confusion and hard to read.


//: [Next](@next)
