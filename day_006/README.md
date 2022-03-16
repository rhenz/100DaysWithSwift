# Day 6: Closures Part 1

## Notes

### Creating basic closure

Basically, closure is another way to compose a function in Swift and closure can be passed around as a variable. This means we can create a function and assign it to a variable, call that function using that variable, and even pass that variable into other functions as parameters

```swift
let message = {
    print("I'm riding my motorcycle")
}

// Call this closure using the variable you created
message() // Prints "I'm riding my motorcycle"
```


### Accepting parameters in a closure

Closures can also accept parameters like regular functions, you put the parameters inside the closure with parentheses and write `in` after the parentheses:

```swift
let message = { (vehicle: String) in
    print("I'm driving my \(vehicle)")
}


message("Honda Civic")
```

The only difference between a function and a closure is that closure don't have parameter labels when running it.

### Returning values from a closure

Yep. Closures can return values as well like regular functions, we just write the return data type before `in`

```swift
let driving = { (vehicle: String) -> String in
    return "I'm driving my \(vehicle)" 
}


let message = driving("Honda Civic")
print(message) // I'm driving my Honda Civic
```

### Closures as parameters

This is the fun part wherein we can pass around closures as parameters in functions. If we want to pass a closure into a function, we have to specify the exact type of that closure and specify that type to the function's parameter type:

```swift
let message = {
    "I'm driving my car."
}


func travel(action: () -> Void) {
    print("I'm getting ready to go")
    action()
    print("I arrived")
}

travel(action: message)
```

### Trailing closure syntax

If the last parameter to a function is a closure, swift lets you use a special syntax called _trailing closure_. So rather than passing your closure as a parameter, you pass it directly after the function inside braces


```swift
func travel(action: () -> Void) {
    print("I'm getting ready to go")
    action()
    print("I arrived")
}

// This is trailing closure
travel {
    print("I'm driving my motorcycle")
}
```