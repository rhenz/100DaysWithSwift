# Day 27: Project 5, Part one

## Notes
On this day we start a new project again. This project is a word game that deals with anagrams.


We are using a `.txt` file here that we are going to load into an array of Strings. This _text file_ consist of thousands of words separated by new lines.

To get the URL of a file in a bundle, we write:
```swift
if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: ".txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
}
```

`String` has a init function that can load a text from a URL and then we use the `components(separatedBy:)` method to get all the words and load it to the array of strings

`try?` keyword is also introduced here. This basically means that if the `try?` fails just return a `nil` value.

Adding textfield inside `UIAlertController` was also introduced here. `UIAlertController` has a method of `addTextField()` for this.
```swift
let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
ac.addTextField()
```

## Screenshots:
![App-Screenshot](documentation/1.png)
