# Day 39: Project 9, Part One

## Notes
- Setting up
- Why is locking the UI Bad
- GCD 101: async()
- Back to the main thread:
- Easy GCD using performSelector


If you are executing any slow code, you should be doing it on the background thread else your app will look like it freezed until the task is done it will unfreeze.

To resolve this, we need to learn some GCD functions, the most important one is `async()` - it means "run the following code asynchronously," i.e. don't block(stop what I'm doing right now) while it's executing.

_GCD_ or Grand Central Dispatch is used for managing concurrent operation, it is a low-level API. The main purpose of GCD is to manage the heavy task in the background.

GCD creates for you a number of queues, and places tasks in those queues depending on how important you say they are.


“How important” some code is depends on something called “quality of service”, or QoS, which decides what level of service this code should be given. Obviously at the top of this is the main queue, which runs on your main thread, and should be used to schedule any work that must update the user interface immediately even when that means blocking your program from doing anything else. 

There are four background queues:

1. **User Interactive:** this is the highest priority background thread, and should be used when you want a background thread to do work that is important to keep your user interface working. This priority will ask the system to dedicate nearly all available CPU time to you to get the job done as quickly as possible.
2. **User Initiated:** this should be used to execute tasks requested by the user that they are now waiting for in order to continue using your app. It's not as important as user interactive work – i.e., if the user taps on buttons to do other stuff, that should be executed first – but it is important because you're keeping the user waiting.
3. **The Utility queue:** this should be used for long-running tasks that the user is aware of, but not necessarily desperate for now. If the user has requested something and can happily leave it running while they do something else with your app, you should use Utility.
4. **The Background queue:** this is for long-running tasks that the user isn't actively aware of, or at least doesn't care about its progress or when it completes.


Those QoS queues affect the way the system prioritizes your work: User Interactive and User Initiated tasks will be executed as quickly as possible regardless of their effect on battery life, Utility tasks will be executed with a view to keeping power efficiency as high as possible without sacrificing too much performance, whereas Background tasks will be executed with power efficiency as its priority.


There are times we need to update the UI once a task is done in the background. We do that by returning back to the _main thread_ using `DispatchQueue.main`.

So the patter in real life is we do all slow work off the main thread, then push work back to the main thread when we want to do user interface/UI work.

Another way to use GCD is using the `performSelector()`:
- `performSelector(inBackground:)`
- `performSelector(onMainThread:)`


```swift
performSelector(inBackground: #selector(fetchJSON), with: nil)
performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
```

So it's up to you which way/method you prefer to implement GCD on your codes.

## Screenshots:
![App-Screenshot](documentation/1.gif)
