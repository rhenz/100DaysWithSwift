# Day 23: Milestone: Project 1-3 

## Notes

On this day, we mainly reviewed what we have learned from Project 1-3.

## Challenges:
The challenge is to create an app that lists various world flags in a table view. When one of them is tapped, slide in a detail view controller that contains an image view, showing the same flag full size. On the detail view controller, add an action button that lets the user share the flag picture and country name using UIActivityViewController.

- Start with a Single View App template, then change its main ViewController class so that builds on UITableViewController instead.
- Load the list of available flags from the app bundle. You can type them directly into the code if you want, but it’s preferable not to.
- Create a new Cocoa Touch Class responsible for the detail view controller, and give it properties for its image view and the image to load.
- You’ll also need to adjust your storyboard to include the detail view controller, including using Auto Layout to pin its image view correctly.
- You will need to use UIActivityViewController to share your flag.


I've completed the challenges here. I added some happy & sad path for some error handling.

## Screenshots:
![App-Screenshot](documentation/1.gif)
