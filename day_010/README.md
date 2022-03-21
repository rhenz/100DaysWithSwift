# Day 10: classes and inheritance

## Notes

### Creating your own classes

Using class is another way to create a new type with properties and methods. Use `class` keyword followed by class name.

The first difference between `class` and `struct` is that classes never come with a memberwise initializer. We should always create an initializer for Classes, unless you provide default values to its properties.

```swift
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let hachi = Dog(name: "Hachi", breed: "Shi Tzu")


class Cat {
    var name: String = "Chabby"
    var breed: String = "Scottish Fold"
}

let chabby = Cat()
```

### Class inheritance 

Second difference between `class` and `struct` is _class inheritance_. This means you can create a `class` based on an existing class then it inherits all of its properties and methods of the parent class. You can also add its own on top.

_Class inheritance_ is also known as _subclassing_, the `class` you inherit from is called _parent class_ or _superclass_, and the new class is called _child class_

```swift
class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

class Poodle: Dog {
    // We can create our own initializer here if we want to
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}

// For safety reasons, Swift always makes you call super.init() from child classes – just in case the parent class does some important work when it’s created.
```

### Overriding methods

_Child classes_ can modify the _parent class_ methods with their own implementation and this is called _overriding_

```swift
class Dog {
    func makeNoise() {
        print("Woof!")
    }
}

class Poodle: Dog {
    
    // This is how we can override methods of superclass method
    override func makeNoise() {
        print("Arf!")
    }
}

let hachi = Poodle()
hachi.makeNoise()
```

Swift will require you to use `override` keyword before the `func` keyword when overriding a method

### Final class

In Swift, if you don't want any developers to inherit from your class you can mark it as a _Final class_

You use `final` keyword before declaring the class:

```swift
final class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
```

AFAIK, properties and methods can also be marked as `final` if you don't want them to be overriden for any reason.


Swift's `final` keyword is a technique to optimize your code in a powerful way as well. 

(How To Use Swift's Final Keyword)[https://cocoacasts.com/swift-fundamentals-how-to-use-swift-final-keyword]


### Copying objects

Since classes are reference type, if you copy an instance to a new variable, you just pass the reference/pointer to that instance. Hence when you edit the new variable's property, it will also update the other variable's property:

```swift
class Singer {
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

var singerCopy = singer
singerCopy.name = "Justin Bieber"

print(singer.name)
```

### Deinitializers

Swift classes have deinitializer using the `deinit` method. This method runs when an instance of a class is destroyed

```swift
class Person {
    var name = "John Doe"

    init() {
        print("\(name) is alive!")
    }
    
    deinit {
        print("\(name) is no more!")
    }

    func printGreeting() {
        print("Hello, I'm \(name)")
    }
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}
```

### Mutability

Unlike struct wherein you have constant struct with a variable property, that property can't be changed because struct itself is a constant

However, if you have a constant class with a variable property, that property can be changed. 

```swift
class Singer {
    var name = "Taylor Swift"
}

let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)
```