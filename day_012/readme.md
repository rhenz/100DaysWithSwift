# Day 12: Optionals

## Notes

### Handling missing data / optionals


Swift have optionals, you can make any time optional. Which means it can have a value or no value at all, which is nil in swift

```swift
var age: Int? = nil


age = 38
```

`age` here is optional integer, meaning we still have to unwrap it if we want to use it like in arithmetic operation


### Unwrapping optionals

One way to unwrap _optional_ values in swift is called, _optional binding_ using `if let` statement:


```swift
var age: Int? = 1

if let unwrappedValue = age {
    print("Age value is: \(unwrappedValue)")
} else {
    print("Age has no value / nil")
}
```


### Unwrapping with `guard let`

Another way to unwrap _optional_ values with _optional binding_ is using the `guard let`


The main difference between `if let` and `guard let` is that your unwrapped optional remains usable after the `guard` code

```swift
func greetPerson(_ name: String?) {
    guard let unwrappedValue = name else {
        print("Name has no value/nil")
        return
    }

    print("\(Hello, \(unwrappedValue))")
}
```


### Force unwrapping

Another way to unwrap an optional value is by doing force unwrapping. But keep in mind that this is a dangerous way to unwrap optional value as it could lead to crashes in your app.

Only do force unwrapping if you're sure that your optional value is not nil

```swift
var name: String? = "Lucas"

let forceUnwrappedValue = name!

var name1: String? = "Chabby"
let forceUnwrapCrash = name1!
```

### Implicitly unwrapped optionals

Implicitly unwrapped optionals behaves as an optional. In swift standard library they are defined differently. What's important is that an implicitly unwrapped optionals is allowed to have no value.

With this, we can access the value of implicitly unwrapped optionals without doing any optional binding. But you can still do so if you want to.

```swift
var text: String! = nil
```

Implicitly unwrapped optionals are a compromise between safety and convenience.


"Sometimes it is clear from a program's structure that an optional will always have a value, after the value is first set. In these cases, it is useful to remove the need to check and unwrap the optional's value every time it is accessed, because it can be safely assumed to have a value all of the time. - The Swift Programming Language"

Normally, implicitly unwrapped optionals are used in `Outlets` / `IBOutlet`

### Nil coalescing

The nil coalescing operator unwraps an optional and returns the value inside if there is one. If there isn’t a value – if the optional was nil – then a default value is used instead. 

```swift
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

let user = username(for: 15) ?? "Anonymous"
```

### Optional chaining

Optional chaining is the process of calling properties, methods and subscripts of an optional that might be nil. If it contains a value, the property or method call is success, otherwise it is nil.

```swift
let names = ["John", "Paul", "George", "Ringo"]

let beatle = names.first?.uppercased()
```

### Optional try

```swift
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
```

The keyword `try?`, when used can return an optional. If the function throws an error you will receive a `nil` as a result, otherwise the return value warapped as an optional

```swift
if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}
```

Other keyword is `try!` which is another dangerous way to call function with

```swift
try! checkPassword("sekrit")
print("OK!")
```

### Failable initializers

Basically, it's an initializer which can result to a nil value using the keyword `init?`

```swift
struct Person {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}
```

### Typecasting

Is a way to check the type of an instance, or to treat that instance as a different superclass or subclass from somewhere else in its own class hierarchy.

Typecasting in swift is implemented using `is` and `as` keywords



```swift
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

// Checking type using Type Casting
var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}
```