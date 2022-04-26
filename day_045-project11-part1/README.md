# Day 45: Project 11, Part One

## Notes
On this day we start again with a new project, but this time we're creating a simple game not using UIKit but instead we are going to use SpriteKit this time.

`SKSpriteNode` was used to create an image in the game, and it can load any image we want from our app bundle.

```swift
let ball = SKSpriteNode(imageNamed: "ballRed")
ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
ball.physicsBody?.restitution = 0.4
ball.position = location
addChild(ball)
```

`SKPhysicsBody` this class adds physics to the image we created using `SKSpriteNode`. On this case, the image added will on the ground and it also bounces.



## Screenshot:
![App-Screenshot](documentation/1.png)

