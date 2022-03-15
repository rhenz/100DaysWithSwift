//: [Previous](@previous)

import Foundation

enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}


do {
    let passwordResult = try checkPassword("password")
} catch {
    print("Error: \(error)")
}
//: [Next](@next)
