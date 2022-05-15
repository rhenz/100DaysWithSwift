# Day 64: Project 18, Part One

## Notes
Today we start again with a new simple project and we're going to tackle different methods of debugging your app.

## Basic Swift Debugging using `print()`
`print` debugging method - a method where everyone starts

```swift
print("I'm inside the viewDidLoad() method!")
```

`print` fuction can accept multiple values too which makes it a Variadic function

```swift
print(1, 2, 3, 4, 5)
```

`print` function has extra parameters too that you can use which is `separator` and `terminator`

```swift
// Using separator
print(1, 2, 3, 4, 5, separator: "-")
```


Using terminator

```swift
print("Some Message", terminator: "--") // default value of `terminator` is a line break or "\n"
print("Another Message", terminator: "") // giving `terminator` a no value means there will be no line break for next print
```


## Debugging with `assert()`
One level up from `print` are _assertions_. It is a debug-only checks that will force your app to crash if a condition is not true

_assertions_ only happen when you are debbuging. When you build a release version of your app, Xcode automatically disables your assertions so they wont reach your users.
This simply means you can set up an extremely strict environment while you're developing, ensuring that all values are present and correct

```swift
assert(1 == 1, "Math failure!")
assert(1 == 2, "Math failure!") // This will make your app crash on debug builds only
```

## Debugging with breakpoints
You can do a lot with debugging with breakpoints. Just click the line number beside the code to set the breakpoint and run your code. And each time the particular line of code is executed, Xcode will pause the execution for your to inspect/check/debug anything you want. You can also _edit breakpoint_ and set _conditions_ on how you want the breakpoint to execute.

No one knows this a lot, but you can also move the _green highlight_ to any lines if you want to but just be careful on treading as it may crash your app.

You can also set an _Exception Breakpoint_ by going to your _Breakpoint navigator_, click the + button on the lower left, and selection _Exception Breakpoint_. This simply means pause execution as soon as an exception is thrown.

## View Debugging
Xcode has a feature called _Capture View Hierarchy_. This way you can see how your view layout


## Screenshots
![App-Screenshot](documentation/1.png)


