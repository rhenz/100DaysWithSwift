# Day 30: Project 6, Part one

## Notes

On this day we start with a new project. Actually we're just going to copy the _Project2_ and update it accordingly.

We implement autolayout rules on the flags that we have here in order to make it look good in both portrait and landscape. We use the _Aspect Ratio Constraint_ and the _Relation_ between two items with constraint using the _Greater than or Equal Relation_ which just means have atleast `20points` of space for situation of landscape and use the remaining space in portrait.

We also created another project, _Project6b_ to demonstrate the _Visual Format Language_ of creating contraints between views.


```swift
let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
for label in viewsDictionary.keys {
    view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
}
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))
```
