# Day 29: Project 5, Part three

## Notes

### Challenges
- Disallow answers that are shorter than three letters or are just our start word. For the three-letter check, the easiest thing to do is put a check into isReal() that returns false if the word length is under three letters. For the second part, just compare the start word against their input word and return false if they are the same.
- Refactor all the else statements we just added so that they call a new method called showErrorMessage(). This should accept an error message and a title, and do all the UIAlertController work from there.
- Add a left bar button item that calls startGame(), so users can restart with a new word whenever they want to.


There's a subtle bug in this game wherein when you enter a word with all uppercase letters, then entering it again with all lowercase letters -- you'll see it gets entered.

Solution:
```swift
func isOriginal(word: String) -> Bool {
        return !usedWords.contains(where: {$0.caseInsensitiveCompare(word) == .orderedSame})
}
```

or simply change this line:
```swift
usedWords.insert(answer, at: 0)

//into

usedWords.insert(lowerAnswer, at: 0)
```

## Screenshots:
![App-Screenshot](documentation/1.gif)
![App-Screenshot](documentation/1.png)
