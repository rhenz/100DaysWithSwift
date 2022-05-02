# Day 51: Expanding Your Horizons

## Notes

No coding for today. We just watched two conference talks of Paul Hudson.

### Elements of Functional Programming


So what is Functional Programming? In terms of Swift, functional programming means using `let s` instead of `var s` when dealing with data. Meaning it can be less prone to bugs and the intent is much easier to understand than imperative code.

Here are some of the functional methods we have in swift.

`map` allows us to transform array using a transformation closure we specify.

```swift
let nums = [1, 2, 3, 4, 5]
let tripled = nums.map { $0 * 3 } // [3, 6, 9, 12, 15]


let names = ["chabby", "nimbus", "oli"]
let capitalized = names.map { $0.capitalized() }
```

`flatMap` returns an array containing the concatenated results of calling the given transformation with each element of the sequence

```swift
let numbers = [1, 2, 3, 4]

let mapped = numbers.map { Array(repeating: $0, count: $0) }
// [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]

let flatMapped = numbers.flatMap { Array(repeating: $0, count: $0) }
// [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
```

`filter` returns an array containing, in order, the elements of the sequence that satisfy the given predicate

```swift
let cast = ["Vivien", "Marlon", "Kim", "Karl"]
let shortNames = cast.filter { $0.count < 5 }
print(shortNames)
// Prints "["Kim", "Karl"]"
```

`reduce` returns the result of combining the elements of the sequence using the given closure.

```swift
let numbers = [1, 2, 3, 4]
let numberSum = numbers.reduce(0, { x, y in
    x + y
})
// numberSum == 10
```



