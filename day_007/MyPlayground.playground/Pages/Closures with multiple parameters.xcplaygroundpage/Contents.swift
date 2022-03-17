//: [Previous](@previous)

import Foundation

func travel(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}

travel { place, speed in
    return "I'm going to \(place) at \(speed) miles per hour"
}

travel {
    return "I'm going to \($0) at \($1) miles per hour"
}


//: [Next](@next)
