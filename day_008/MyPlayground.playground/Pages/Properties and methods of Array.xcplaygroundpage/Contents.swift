//: [Previous](@previous)

import Foundation

var toys = ["Woody", "Buzz"]

// Read count of items in an array
toys.count

// Add new item in the array
toys.append("Jessie")

// You can locate any item inside an array using firstIndex() method
toys.firstIndex(of: "Buzz") // This will return index 1

// Arrays can also be sorted
toys.sorted()

// We can also remove an item in the array using index parameter
toys.remove(at: 0)

struct Toy {
    var name: String
}

var toy1 = Toy(name: "Toy Car")
var toy2 = Toy(name: "Bicycle")

var kidToys = [toy1, toy2]
let sortedToys = kidToys.sorted(by: { $0.name < $1.name })
sortedToys

//: [Next](@next)
