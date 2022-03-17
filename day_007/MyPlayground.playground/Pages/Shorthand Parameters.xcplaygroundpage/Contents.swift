//: [Previous](@previous)

import Foundation

func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel { place in
    return "I'm going to \(place) in my car"
}


// Shorthand syntax. These are named with a dollar sign, then number counting from 0
travel {
    "I'm going to \($0) in my car"
}

//: [Next](@next)
