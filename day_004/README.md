# Day 4: Loops, loops and more loops!

## Notes

### For loops

_For loop_ is the most common loop in Swift. You can loop through arrays and ranges, each time the loop goes around it will pull out one item and assign to a constant

```swift
for num in 1...10 {
    print("Number: \(num)") // prints 1 to 10
}
``` 

### While loops
_While loop_ is another way to write a loop in swift. You put a condition first and then the loop statement will go around and around until the condition is false. 
Be careful on writing while loops though as you may introduce infinite loop on this. Always make sure that the condition will become `false` at certain point. Usually, you create a variable counter, and its value will either increase/decrease depending on your logic and you use that counter to check your `condition` until it becomes false.

```swift
var count = 1
while count <= 10 {
    print("Hello World!")
    count += 1
}
```


### Repeat loops
_Repeat loop_ is the most uncommonly used loop. To be honest, I think I have used this loop in my career. LOL. But it's simple and almost identical to `while loop` except that the condition to check comes later on the code. And because the condition comes at the end of the loop, the code inside the loop will always be executed at least once, unlike `while loop` check their condition before their first run.

```swift
var number = 1
repeat {
    print(number)
    number += 1
} while <= 20
```

### Exiting loops
To exit a loop, you use the keyword `break` and it will stop the loop.

```swift
for num in 1...10 {
    print("Gonna say HI, 5 times...")
    if num == 5 {
        break
    }
}
```


### Exiting multiple loops
Let's say you have nested loop and you want to end the outer loop early, you have to put a label on the outer loop like so:

```swift
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")

        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}
```

### Skipping items on loops
To skip on to the next iteration, we can use the keyword `continue`:

```swift
for i in 1...10 {
    if i % 2 == 1 {
        continue
    }

    print(i)
}
```
