//: [Previous](@previous)

import Foundation

var name: String? = nil


// The most common way to unwrap optionals

if let unwrappedValue = name {
    print("\(unwrappedValue.count) letters")
} else {
    print("Missing name")
}

//: [Next](@next)
