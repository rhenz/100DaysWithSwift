# Day 42: Project 10, Part One

## Notes
- Setting up
- Designing UICollectionView cells
- uicollectionview data source

On this day we start again with a new project. We're gonna start today with creating an app with a `UICollectionView` and custom class of `UICollectionViewCell`.

Creating UICollectionView has similarities with creating a `UITableView`.

`fatalError()` was also introduced here. When this is called, this will unconditionally make your app crash - it will die immediately, and print out any message you provide to it.

You should only call this when things are really bad and you don't want to continue - it's really only a sense check to make sure everything is as we expect.

In our case we are going to use `fatalError()` when `UICollectionViewCell` fails to get the custom `PersonCell` that we have created.



## Screenshot:
![App-Screenshot](documentation/1.png)
