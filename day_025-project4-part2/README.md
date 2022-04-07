# Day 25: Project 4, Part two

## Notes

- UIToolbar & UIProgressView
- Refactoring

On this day, we add `UIProgressView` on a `UIToolbar`.

By default, there's a `UIToolbar` that is `hidden` by default so we have to set the `UINavigationController`'s  `isToolbarHidden` to `false`. Then we create two `UIBarButtonItem`. One is a spacer using `flexibleSpace` and the other one is a _Refresh Button_. We add these two bar button items into `toolbarItems` array


Next is we create a `UIProgressView` that we will put inside the `UIToolbar` but in order to do that we have to put the progress view inside a `UIBarButtonItem` using the initializer with `customView` parameter and add this new bar button item in the `toolbarItems` array and place it before the `spacer`


`KVO` was also introduced on this lecture. We watch the `estimatedProgress` property of our webview to update our `UIProgressView` by adding an observer on our webview.

In complex apps, all `addObserver()` should be matched with a call to `removeObserver()`

Once you  register an observer using `KVO`, we must implement a method called `observeValue()` to watch the `keyPath` of `estimatedProgress` so that we could update our progress view dynamically. 


Lastly, we use a webview delegate method `decidePolicyFor` to gatekeep unnecessary URLs aside from _apple_ and _hackingwithswift_ websites. 


## Screenshots:
![App-Screenshot](documentation/1.gif)
