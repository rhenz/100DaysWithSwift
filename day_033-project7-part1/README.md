# Day 32: Project 7, Part One

## Notes

- Setting Up new project 7
- Introduce using UITabBarController
- Codable
- Parsing jsonData using JSONDecoder

On this day, we start again on a new project wherein we learn about `UITabBarController`, `Codable` and `JSONDecoder`

First is we setup our initial view controller with a `UINavigationController` and embed it on a `UITabBarController`.

We created a new model struct here called `Petition` and `Petitions` and conform them to a `Codable` protocol which will handle most of the parsing under the hood.

```swift
struct Petitions: Codable {
    var results: [Petition]
}

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
```

Next is we get the contents of URL as a `Data` using `Data(contentsOf:)` putting it on a variable `jsonData` and we create a method to initiate the `JSONDecoder` which will decode the `jsonData` that we got from our URL as a `Data` and reload the tableView to present all the Petitions.

```swift
if let jsonPetitions = try? decoder.decode(Petitions.self, from: jsonData) {
    petitions = jsonPetitions.results
    tableView.reloadData()
}
```

## Screenshots:
![App-Screenshot](documentation/1.png)
