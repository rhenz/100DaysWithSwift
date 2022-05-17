import Foundation
import Darwin

class MenuItem {
    let name: String
    init(name: String) {
        self.name = name
    }
    deinit {
        print("Menu Item '\(name)' deinit")
    }
}

class Menu {
    var favoriteItem: MenuItem?
    init(favoriteItem: MenuItem) {
        self.favoriteItem = favoriteItem
    }
}

var myMenu = Menu(favoriteItem: MenuItem(name: "fries"))
print("Removing favorite item from the Menu...")
sleep(3)
myMenu.favoriteItem = nil
// Prints: Menu Item 'fries' deinit
