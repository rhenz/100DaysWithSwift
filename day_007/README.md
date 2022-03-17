# Day 6: Closures Part 2

## Notes

### Using closures as parameters when they accept parameters

This is the time wherein closures may be a bit hard to read. So yes, a closure you pass into a function can also accept its own parameters:

```swift
func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

// now we can call travel using traling closure syntax, our closure code is required to accept a string
travel { (place: String) in
    print("I'm going to \(place) in my car")
}
```

### Using closures as parameters when they return values

We can also use closures as a parameters even when they return values. We just replace the `void` keyword with whatever data type we need to return in the closure

```swift
func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
```

### Shorthand parameters names

So far, we haven't done the shortest way to write trailing closures with parameters. Here's an example:

```swift
func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

// we normally call travel() like this:
travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

// however under the hood, Swift knows the parameter name to this closure so we can remove it
travel { place -> String in
    return "I'm going to \(place) in my car"
}

// Swift knows also under the hood that the closure must return a string so we can omit that as well, you can also omit the return keyword if you want to
travel { place in
    return "I'm going to \(place) in my car"
}

// Swift has shorthand syntax that lets you write closure much much shorter. Swift provides automatic names for the closure's parameters. These are named with a dollar sign, then a number counting from 0
travel {
    return "I'm going to \($0) in my car"
}

```

### Closures with multiple parameters

Closures can also have multiple parameters like a regular function. Simply write the data types separated by commas:
```swift
func travel(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}

travel { place, speed in
    return "I'm going to \(place) at \(speed) miles per hour"
}

// Example of trailing closures using the shorthand dollar keyword with multiple parameters
travel {
    "I'm going to \($0) at \($1) miles per hour."
}
```


### Returning closures from functions

We can also return closures from functions if we need to. It can be confusing sometimes because `->` is used twice.

```swift
func travel() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

let result = travel() // so we get a closure from this call
result("London") // then you can use the variable like so


### Capturing values

Closure capturing happens likes this:

```swift
func travel() -> (String) -> Void {
    var counter = 1

    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}
```

Even though the variable `counter` was created inside travel(), it gets captured by the closure then this value will still remain  alive for that closure.

```swift
let result = travel()
result("London")
result("London")
result("London")
```

So if we call the closure multiple times, the counter will go up
