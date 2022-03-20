import UIKit

struct User {
    var username: String

    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user = User()
user.username = "renz"


// Default initializer, memberwise initializer
/*
struct User {
    var username: String
}

var user = User(username: "lucas")
*/
