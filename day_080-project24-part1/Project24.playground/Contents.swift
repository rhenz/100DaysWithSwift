import UIKit


/*:
 Strings Are Not Array
 
 Though we could loop through Strings like this:
 */

let name = "Lucas"

for letter in name {
    print("Letter: \(letter)")
}

//: However, you can't use subscripts in Strings like this:
//name[3]


//: If you want to read a specific letter place, we must do it like this
let letter = name[name.index(name.startIndex, offsetBy: 2)] // This should be letter "C"



//: Also, doing a name.count is not a quick operation. If you just need to check if a string is empty, don't use the count property, use .isEmpty instead.





//: There are methods for checking strings if it starts with or ends with a substring
let password = "12345"
password.hasPrefix("123")
password.hasSuffix("345")


//: There are also methods and property like this
let weather = "it's going to rain"
weather.lowercased()
weather.uppercased()
weather.capitalized


//: Another useful method of strigns is contains()
let input = "Swift is like Objective-C without C"
input.contains("Swift")

//: Another useful thing we could do with Strings in swift is we can make it an Attributed String from Plain String

let string = "This is a test string"
let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]

let attributedString = NSAttributedString(string: string, attributes: attributes)


let attributedString1 = NSMutableAttributedString(string: string)
attributedString1.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString1.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString1.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString1.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString1.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))
