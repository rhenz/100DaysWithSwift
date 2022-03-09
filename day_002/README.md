# Day 2: Complex data types

## Notes

### Arrays

Swift Arrays are one of the most commonly used data types in iOS Development. You use arrays to organize your app's data. You use array to hold elements of a single type. Elements are always enclosed in square brackets `[ ]`

Arrays can store any kind of elements. Arrays automatically infers element's type

```swift
var numbers = [1, 2, 3, 4, 5] // Ints
var names = ["John", "Lucas", "Chabby", "Oli", "Nimbus", "Angela"] // Strings
```

You can access an element of an array, you can use array variable followed by index which is enclosed in square brackets:
```swift
var names = ["John", "Lucas", "Chabby", "Oli", "Nimbus", "Angela"]
names[0] // John
names[1] // Lucas
names[6] // Error, index out of range

```

Be careful in accessing elements of an array using its index. Only use this when you are sure that the index is not out of range. This error is undetectable on build time and can only show up on runtime which is fatal in production code.


### Sets
Swift Sets is a collection type of Swift that cannot contain duplicate values. You can use `set` instead of `array` when order of items is not important or when you need to ensure that an item should only appear once.

You can create a set with an arrray literal:
```swift
let colors = Set(["red", "green", "blue"])

let colors2 = Set(["red", "red", "blue", "green"]) //red will only appear once
```

### Dictionaries
Swift Dictionaries is also a collection type of Swift. Its elements are key-value pairs:

```swift
var student = ["name": "Lucas", "gender": "Male"]
student["name"] // Lucas
student["gender"] // Male
```

If there's a key that's not present in the dictionary it will return `nil`. You can also return default value if you need so.
```swift
var student = ["name": "Lucas", "gender": "Male"]
student["favoriteSubject"] // returns nil
student["favoriteSubject", default: "Math"] // returns "Math"
```

### Tuples
Swift Tuples is a group of different values and each value inside the tuple can be different data types.

```swift
var cat = (name: "Chabby", age: 2)

cat.name // Chabby
cat.age // 2

cat.0 // Chabby
cat.1 // 2
```

### Creating Empty Collections


```swift
// Array
let names = [String]()
let colors = Array<String()
let students: [String] = []

// Set
let sampleSet = Set<String>()
let sampleSet2: Set<String> = [] 

// Dictionary
let studentDictionary = Dictionary<String, String>()
let babyRecords: [String: String] = [:]
```

### Enumerations
Keyword `enum` is needed to define an enumeration. Enumeration is user defined data type that consists of set of related values. 

Enumeration defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code.

```swift
enum ExamResult {
	case pass
	case fail
}
```

_Enumeration with Associated Values_
Sometimes we want to attach additional information to enum values. These additional information are called ASSOCIATED VALUES

```swift
enum Student {
	case name(String)
	case favoriteSubject(String)
}

var studentDetail = Student.name("Lucas")
var studentFavoriteSubj = Student.favoriteSubject("Math")



enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "volleyball")
```

_Enumeration Raw Values_
Sometimes we need to assign values to enums so they could have meanings. 

```swift
enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}

// venus will have rawValue of 2, earth 3, mars 4
```


