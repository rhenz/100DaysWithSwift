//: [Previous](@previous)

import Foundation

struct Student {
    static var classSize = 0
    var name: String

    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let lucas = Student(name: "Lucas")
let chabby = Student(name: "Chabby")

print(Student.classSize)

//: [Next](@next)
