//: [Previous](@previous)

import Foundation

let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

favoriteIceCream["Paul"]

favoriteIceCream["Charlotte"] // This will return nil

// So instead of returning nil value from unavailable identifier/key. We can return a default value in any case that you need to.
let result = favoriteIceCream["Charlotte", default: "Unknown Favorite Ice Cream"]

//: [Next](@next)
