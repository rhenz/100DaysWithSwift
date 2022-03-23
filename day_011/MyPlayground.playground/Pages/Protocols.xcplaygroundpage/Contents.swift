import UIKit

protocol Identifiable {
    var id: String { get set }
}


struct User: Identifiable {
    var id: String
}

var lucas = User(id: "LucasID")

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

displayID(thing: lucas)
