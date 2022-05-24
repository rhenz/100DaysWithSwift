import Foundation

protocol HealthyFood {
    var name: String { get }
}

struct Fruit: HealthyFood {
    var name: String
}

struct Vegetable: HealthyFood {
    var name: String
}

let f1 = Fruit(name: "Apple")
let f2 = Fruit(name: "Banana")
let f3 = Fruit(name: "Orange")
let v1 = Vegetable(name: "Carrot")
let v2 = Vegetable(name: "Okra")
let v3 = Vegetable(name: "Spinach")


let healthyFoods: [HealthyFood] = [f1, f2, f3, v1, v2, v3]

for case let healthyFood as Vegetable in healthyFoods {
    print(healthyFood.name)
}

//for healthyFood in healthyFoods where type(of: healthyFood) == Vegetable.self {
//    print(healthyFood.name)
//}

//for case let healthyFood as Vegetable in healthyFoods {
//    print(healthyFood.name)
//}
