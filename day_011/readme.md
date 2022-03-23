# Day 11: protocols, extensions, and protocol extensions

## Notes

### Protocols

Protocols are a way of describing what properties and methods a type should have. We use that protocol in a process known as adopting or conforming to a protocol


```swift
protocol Identifiable {
    var id: String { get set }
}

struct User: Identifiable {
    var id: String
}
```

So in this example, `User` conforms to `Identifiable`, therefore it must declare the `id` property.


If you have any function or method that has a parameter type of `protocol`, we can use any type there that conforms to that `protocol`:

```swift
func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

var lucas = Lucas(id: "lucas123")

displayID(thing: lucas) // prints "My ID is lucas123"
```


### Protocol inheritance

One protocol can inherit from another and we call that _protocol inheritance_

```swift
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}


// We can now create a single Employee protocol that brings them together in one protocol

protocol Employee: Payable, NeedsTraining, HasVacation { }
```

### Extensions

In swift, we can create `extension` that allows us to add methods or computed properties to existing types


```swift
extension Int {
    func squared() -> Int {
        return self * self
    }
}

let num = 10
num.squared()

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

num.isEven  // true
```

### Protocol extensions

In swift, we can also create extensions for protocols if we need to define what code is inside that method

```swift
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

extension Collection {
    func summarize() {
        print("There are \(count) of us:")

        for name in self {
            print(name)
        }
    }
}

pythons.summarize()
beatles.summarize()
```

### Protocol-oriented programming

Protocol extensions can provide default implementations for our own protocol methods. This makes it easy for types to conform to a protocol, and allows a technique called “protocol-oriented programming” – crafting your code around protocols and protocol extensions.

```swift
protocol Identifiable {
    var id: String { get set }
    func identify()
}

extension Identifiable {
    func identify() {
        print("My ID is \(id).")
    }
}


// Now when we create a type that conforms to Identifiable it gets identify() automatically
struct User: Identifiable {
    var id: String
}

let twostraws = User(id: "twostraws")
twostraws.identify()
```