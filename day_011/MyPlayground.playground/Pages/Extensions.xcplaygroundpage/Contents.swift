//: [Previous](@previous)

import Foundation

extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number = 8
number.squared()
//: [Next](@next)


// Swift doesn't let you add stored properties in extensions. You should use computed properties instead
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}
