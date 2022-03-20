//: [Previous](@previous)

import Foundation

struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct Person {
    var name: String
    lazy var familyTree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}

print("FamilyTree() not yet created..")
var ed = Person(name: "Ed")
ed.familyTree // This is the only time that the `FamilyTree()` initialization happens


//: [Next](@next)
