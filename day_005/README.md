# Day 5: FUNCTIONS!

## Notes

### Writing functions

Writing a function in swift should start with a `func` keyword then function name followed by parentheses: 

```swift
func sayHello() {
    print("Hello")
}
```


### Accepting parameters

Functions are more useful when then can be customized each time you run them. To make your function accept parameters, give each parameter a name, then colon, followed by Swift data type. All this goes inside the parentheses:

```swift
func sayHello(name: String) {
    print("Hello, \(name)")
}
```

You can use the parameter name as a constant inside the function like so.


### Returning values

Functions can also return values when needed. To do this, write a dash followed by right angle bracket after the parentheses, then indicate what kind of data you should return:


```swift
func square(number: Int) -> Int {
    return number * number
}
```

Inside your function, you should use the `return` keyword to send a value back if you have one. Xcode will warn you if you don't return anything or if the data youre trying to return is not the same as the expected return data type.
 


### Parameter labels

We wrote a `sayHello(name: String)` function earlier. The `name` is the parameter name.

Swift allows us to use two parameter name, an External and Internal parameter names:

```swift
func sayHello(to name: String) {
    print("Hello, \(name)")
}

// Calling sayHello function is like this now
sayHello(to: "Lucas")
```


### Omitting parameter labels

We can also omit the parameter names by prepending the parameter name with an underscore `_`:

```swift
func sayHello(_ name: String) {
    print("Hello, \(name)")
}


// Without parameter name, you call it like this
sayHello("Chabby")
```

The sample function above doesn't feel like natural to read so sometimes it's better to give your parameters external names to avoid confusions. There will be situations where
you can omit parameter labels like:

```swift
func buy(_ item: String) {
    print("Buying \(item) now.")
}

buy("iPhone")
```

The example above is much more natural to read without the parameter labels.


### Default parameters

Swift functions allows you to put default parameter label as well like this:


```swift
func sayHello(to name: String, nicely: Bool = true) {
    if nicely {
        print("Good day \(name)! Have a nice day!")
    } else {
        print("Oi \(name)!")
    }
}

// Now you can call this method in two different ways, with or without the nicely parameter name
sayHello(to: "Lucas")
sayHello(to: "Chabby", nicely: false)
```

### Variadic function

Some functions can be declared variadic, a fancy way to say that this function could accept multiple values of same data type:

```swift
func sayHello(to names: String...) {
    for name in names {
        print("Hello, \(name)!")
    }
}

sayHello(to: "Chabby", "Lucas")
```

### Writing throwing function

Swift function can throw `error` by marking them as `throws` before their return type and then using the `throw` keyword when something goes wrong


First declare an enum and conform to `Error` type:

```swift
enum PasswordError: Error {
    case obvious
}

func changePassword(to password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}
```


### Running throwing function

In order to run a throwing function, you can wrap it in a `do-catch` statement:

```swift
do {
    try changePassword(to: "password")
    print("Good password")
} catch {
    print("Too obvious! \(error)")
}

// This prints "To obvious", you can use `error` constant if you want to printout what kind of error you encounter
```


### inout parameters

Swift functions can also let you change a variable outside of its function by using `inout` parameters:


```swift
func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 20
doubleInPlace(number: &myNum)
```

You need to pass the parameter using an ampersand `&`