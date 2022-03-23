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
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}

// Only do this if you are sure that the function won't fail 100% or else this will cause a crash on your app
try! checkPassword("sekrit")
print("OK!")

//: [Next](@next)
