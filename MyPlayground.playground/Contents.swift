import UIKit


class House {
    var ownerDetails: (() -> Void)?
    
    func printDetails() {
        print("This is a great house.")
    }
    
    deinit {
        print("I'm being demolished!")
    }
}

class Owner {
    var houseDetails: (() -> Void)?
    
    func printDetails() {
        print("I own a house")
    }
    
    deinit {
        print("I'm dying!")
    }
}


print("Creating a house and an owner")

do {
    let house = House()
    let owner = Owner()
    
    // Create strong reference
//    house.ownerDetails = owner.printDetails
//    owner.houseDetails = house.printDetails
    
    house.ownerDetails = { [weak owner] in owner?.printDetails() }
    owner.houseDetails = { house.printDetails() }
}

print("Done")


/*
var numberOfLinesLogged = 0

let logger1 = {
    numberOfLinesLogged += 1
    print("Lines logged: \(numberOfLinesLogged)")
}

logger1()

let logger2 = logger1
logger2()
logger1()
logger2()
 */
