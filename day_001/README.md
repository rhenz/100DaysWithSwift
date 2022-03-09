# Day 1: variables, simple data types, and string interpolation

## Notes

### Constants & Variables

Swift variables are initialized with a `var` keyword. You can think of it like a shoebox and contains something. You can open the box to see what's inside or even put something
else inside the shoebox.

_Variables_ can change value as long as it is same type. We can even declare a variable without a value as long as you explicitly declare its type like so:

```swift
var age: Int
age = 99

var name: String
name = "Lucas"
```

_Constants_, its value cannot be changed. Constants are initialized with `let` keyword


Xcode will also notify you if the variable you declared didn't change at all and will ask you to consider using constant istead.


### Strings and Integers
Declaring strings should be always be between double quotes and integers doesn't need it, or else it will be inferred as a String

You can use underscores to make big numbers more readable like:
```swift  
let lottoJackpot = 1_000_000_000
```


### Multi-line Strings
In any case you need to declare long long set of strings, better use multi-line for readability and it should be enclosed in triple double quotes like
```swift
var greeting = """
hello
world
"""
```

### Doubles and Booleans
Whenever you create variable with a fractional number, Swift automatically sets it type to `Double`

As for booleans, they just hold `true` or `false` values:
```swift
let mySonIsCute = true
```

### String Interpolation
It's the ability to put variable inside your strings to make them more useful. You can place any variable inside your string, you write backslash followed by your variable name inside parentheses:
```swift
var catAge = 3
var str = "My cat is \(catAge) years old."
```


### Type Annotation

Type inference can be explicit or left up the compiler. For personal preference, I like to declare the type explicitly for uniformity as there are times we need to declare some types explicitly.

