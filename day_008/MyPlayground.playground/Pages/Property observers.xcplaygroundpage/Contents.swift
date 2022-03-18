//: [Previous](@previous)

import Foundation

struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
    
    // willSet can also be used, but this happens before a property changes and this is rarely used
}

//: [Next](@next)
