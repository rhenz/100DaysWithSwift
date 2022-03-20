# Day 9: access control, static properties, and laziness

## Notes

### Initializer

Initializers are special methods that provides you different ways to create your struct. Remember that all structs come with one by default, is it called _memberwise initializer_

```swift
struct User {
    var username: String
}

var user = User(username: "twostraws") // default initializer since username property doesn't hold any value
```

And like regular Classes, we can also provide our own initializer if we need to.

Remember that you don't need to write `func` keyword before initializers' function name. But you need to make sure that all properties have a value before the initializer ends.

### Referring to the current instance

Inside _methods_ we get a special constant called `self`. This points to whatever instance of the struct is currently being used. This `self` keyword is commonly used when we create initializers that have same parameter names as our properties.

```swift
struct Person {
    var name: String

    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}
```

### Lazy properties

For performance optimization, we can create some properties when only needed:

```swift
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct Person {
    var name: String
    lazy var familyTree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}

print("FamilyTree() not yet created..")
var ed = Person(name: "Ed")
ed.familyTree // This is the only time that the `FamilyTree()` initialization happens
```

### Static properties and methods

In swift, we can share specific properties and methods across all of its instances by declaring it _static_

```swift
struct Student {
    static var classSize = 0
    var name: String

    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let lucas = Student(name: "Lucas")
let chabby = Student(name: "Chabby")

print(Student.classSize)
```

Because `classSize` property is a static property. We need to prepend `Student` in order to read the `.classSize`


### Access control

In swift, we can restrict which code can use properties and methods like:

```
struct Person {
    private var id: String

    init(id: String) {
        self.id = id
    }
}

let ed = Person(id: "12345")

// ed.id //not possible as the property id is private
```

There are still other access control keywords like `fileprivate`, `open`, `public`, `internal`. 