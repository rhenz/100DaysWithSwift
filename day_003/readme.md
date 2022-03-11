# Day 3: Operators and conditions

## Notes

### Arithmetic Opeartors
Swift supports the four standard arithmetic operators

```swift
let add = 1 + 1
let subtract = 1 - 1
let multiply = 2 * 3
let divide = 6 / 2
```

Swift also supports Remainder Operator
```swift
let remainder = 5 % 2 // 1
```

### Operator overloading
This is just a fancy way of saying that what an operator does depends on the values you use it with

You can use it with arrays:
```swift
let students1 = ["John", "Lucas"]
let students2 = ["Chabby", "Angela"]
let allStudents = students1 + students2
```

Strings:
```swift
let firstName = "John " + 
let secondName = firstName + " Lucas"
```


### Compound Operators
Mainly compound operators provide a shorter syntax for assigning the result of an arithmetic.

Example:
```swift
var score = 95
score += 5 // 100
```

You can also use Addition compound operator  with Strings:
```swift
var name = "John"
name += " Lucas" //John Lucas
```

### Comparison Operators
Swift has several operators that performs comparison.

There are two operators that checks for equality:
```swift
let num1 = 5
let num2 = 4

num1 == num2 // false
num1 != num2 // true
```

There are four operators for comparing whether one value is greater than, less than, or equal to another
```swift
let num1 = 5
let num2 = 5

num1 <= num2 // true
num1 >= num2 // true
num1 > num2 // false
num1 < num2 // false
```

### Conditions
You can write conditions using `if` statements like:

```swift
let isRunning = true
if isRunning { // true
    print("I'm running, duh?")
}
```

You can use alternative code to run the _false_ condition using `else` statement:
```swift
let isRunning = true
if isRunning { // true
    print("I'm running, duh?")
} else {
    print("Too tired to run.. ")
}
```

You can also chain conditions together using `else if` statement:
```swift
let score = 96

if score == 95 { // true
    print("I'm genius!")
} else if score > 95 {
    print("I'm a god")
} else {
    print("I didn't study. So.. yeah.")
}
```


### Combining Conditions
Swift has two special operators the helps you combine conditions together `&&` and `||`

`&&` = And
`||` = Or


Example:
```swift
let age1 = 21
let age2 = 12

if age1 > 18 && age2 > 18 { // false, since age2 is not greater than 18
    print("Both are over 18")
}
```

### Ternary operator
The ternary operator takes 3 operands ( condition , expression1 , and expression2 ). Hence, the name ternary operator.


```swift
let firstCard = 11
let secondCard = 10
print(firstCard == secondCard ? "Cards are the same" : "Cards are different")
```

### Switch Statements
If you have multiple conditions, it is much better to use `switch` statement as it helps you see the conditions clearly. Using this approach you write your condition once and list all possible outcomes:

```swift
let weather = "sunny"
switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
default:
    print("Enjoy your day!")
}
```

`default` case is required in this scenario. But there are cases wherein you don't need to include `default` case when the condition is of type Enum?



### Range operators
Swift gives use two ways of making range operators, `...` and `..<`

Range operators are really helpful usually in making `switch` statements, for instance:


let score = 95

```swift
switch score {
    case 0...50 {
        print("Score so low")
    case 51..<85:
        print("You did ok")
    default: // 85 and above
        print("Good job!")
    }
}
```



