import UIKit


// Unlike Structs, Classes don't have memberwise initializer. We should always create an initializer for Classes, unless you provide default values to its properties
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let hachi = Dog(name: "Hachi", breed: "Shi Tzu")


class Cat {
    var name: String = "Chabby"
    var breed: String = "Scottish Fold"
}

let chabby = Cat()
