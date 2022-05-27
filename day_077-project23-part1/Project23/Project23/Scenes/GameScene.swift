//
//  GameScene.swift
//  Project23
//
//  Created by John Salvador on 5/27/22.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    enum ForceBomb {
        case never, always, random
    }
    
    // MARK: - Properties
    fileprivate typealias K = GameSceneConstants
    
    var gameScoreLabelNode: SKLabelNode!
    var livesImages = [SKSpriteNode]()
    var lives = 3
    
    var activeSliceBG: SKShapeNode!
    var activeSliceFG: SKShapeNode!
    
    var activeSlicePoints = [CGPoint]()
    var activeEnemies = [SKSpriteNode]()
    
    var isSwooshSoundActive = false
    
    var bombSoundEffect: AVAudioPlayer?
    
    var score = 0 {
        didSet {
            gameScoreLabelNode.text = "Score: \(score)"
        }
    }
    
    // MARK: -
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: Constants.ImageName.sliceBackground)
        background.position = GameSceneConstants.backgroundPosition
        background.blendMode = .replace
        background.zPosition = K.backgroundZPosition
        addChild(background)
        
        physicsWorld.gravity = CGVector(dx: K.xGravity, dy: K.yGravity) // This changes the default gravity, Earth has -0.98 by default
        physicsWorld.speed = K.gravitySpeed // We change the speed of gravity downwards so it stays up a bit longer than regular
        
        createScores()
        createLives()
        createSlices()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        activeSlicePoints.append(location)
        redrawActiveSlice()
        
        if !isSwooshSoundActive {
            playSwooshSound()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeSliceBG.run(SKAction.fadeOut(withDuration: 0.25))
        activeSliceFG.run(SKAction.fadeOut(withDuration: 0.25))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        // Remove all active slice points in our array
        activeSlicePoints.removeAll(keepingCapacity: true)
        
        // Get touch locations that will be added in our array
        let location = touch.location(in: self)
        activeSlicePoints.append(location)
        
        
        // Redraw New Slice
        redrawActiveSlice()
        
        // Remove All Existing Action
        activeSliceBG.removeAllActions()
        activeSliceFG.removeAllActions()
        
        activeSliceBG.alpha = 1
        activeSliceFG.alpha = 1
    }
    
    override func update(_ currentTime: TimeInterval) {
        var bombCount = 0
        
        for node in activeEnemies {
            if node.name == "bombContainer" {
                bombCount += 1
                break
            }
        }
        
        if bombCount == 0 {
            // no bombs – stop the fuse sound!
            bombSoundEffect?.stop()
            bombSoundEffect = nil
        }
    }
    
    
    // MARK: - Helper Methods
    private func createScores() {
        gameScoreLabelNode = SKLabelNode(fontNamed: Styles.FontName.chalkduster)
        gameScoreLabelNode.horizontalAlignmentMode = .left
        gameScoreLabelNode.fontSize = K.gameScoreFontSize
        gameScoreLabelNode.position = K.gameScorePosition
        score = 0
    }
    
    private func createLives() {
        for i in 0..<3 {
            let spriteNode = SKSpriteNode(imageNamed: Constants.ImageName.sliceLife)
            spriteNode.position = CGPoint(x: K.livesImageStartXPos + (i * K.liveImagesWidth), y: K.liveImagesStartYPos)
            addChild(spriteNode)
            livesImages.append(spriteNode)
        }
    }
    
    private func createSlices() {
        activeSliceBG = SKShapeNode()
        activeSliceBG.zPosition = 2
        
        activeSliceFG = SKShapeNode()
        activeSliceFG.zPosition = 3
        
        activeSliceBG.strokeColor = Styles.Color.activeSliceBGColor
        activeSliceBG.lineWidth = 9
        
        activeSliceFG.strokeColor = Styles.Color.white
        activeSliceFG.lineWidth = 5
        
        addChild(activeSliceBG)
        addChild(activeSliceFG)
    }
    
    private func redrawActiveSlice() {
        if activeSlicePoints.count < 2 {
            activeSliceBG.path = nil
            activeSliceFG.path = nil
            return
        }
        
        if activeSlicePoints.count > 12 {
            activeSlicePoints.removeFirst(activeSlicePoints.count - 12)
        }
        
        let path = UIBezierPath()
        path.move(to: activeSlicePoints[0])
        
        for i in 1 ..< activeSlicePoints.count {
            path.addLine(to: activeSlicePoints[i])
        }
        
        activeSliceBG.path = path.cgPath
        activeSliceFG.path = path.cgPath
    }
    
    private func playSwooshSound() {
        isSwooshSoundActive = true
        
        let randomNumber = Int.random(in: 1...3)
        let soundName = "swoosh\(randomNumber).caf"
        
        let swooshSound = SKAction.playSoundFileNamed(soundName, waitForCompletion: true)
        
        run(swooshSound) { [weak self] in
            self?.isSwooshSoundActive = false
        }
    }
    
    private func createEnemy(forceBomb: ForceBomb = .random) {
        let enemy: SKSpriteNode
        
        var enemyType = Int.random(in: 0...6)
        
        if forceBomb == .never {
            enemyType = 1
        } else if forceBomb == .always {
            enemyType = 0
        }
        
        if enemyType == 0 {
            // Create a SKSpriteNote that will hold the fuse and the bomb image as children, setting it Z position to 1
            enemy = SKSpriteNode()
            enemy.zPosition = 1
            enemy.name = "bombContainer"
            
            // Create the bomb image and add it to the container
            let bombImage = SKSpriteNode(imageNamed: Constants.ImageName.sliceBomb)
            bombImage.name = "bomb"
            enemy.addChild(bombImage)
            
            // If the bomb fuse sound effect is playing, stop it and destroy it
            if bombSoundEffect != nil {
                bombSoundEffect?.stop()
                bombSoundEffect = nil
            }
            
            // Create new bomb fuse sound effect, then play it
            if let path = Bundle.main.url(forResource: Constants.SoundName.sliceBombFuse, withExtension: Constants.SoundName.cafExtension) {
                if let sound = try?  AVAudioPlayer(contentsOf: path) {
                    bombSoundEffect = sound
                    sound.play()
                }
            }
            
            // Create particle emitter node, position it so that it's at the end of the bomb's image fuse, and add it to the container
            if let emitter = SKEmitterNode(fileNamed: Constants.EmitterNode.sliceFuse) {
                emitter.position = CGPoint(x: 76, y: 64)
                enemy.addChild(emitter)
            }
        } else {
            enemy = SKSpriteNode(imageNamed: Constants.ImageName.penguin)
            run(SKAction.playSoundFileNamed(Constants.SoundName.launchSoundWithCafExt, waitForCompletion: false))
            enemy.name = "enemy"
        }
        
        // Give enemy random position off the bottom edge of our screen
        let randomPosition = CGPoint(x: Int.random(in: 64...960), y: -128)
        enemy.position = randomPosition
        
        // Create random angular velocity, which is how fast something should spin
        let randomAngularVelocity = CGFloat.random(in: -3...3 )
        let randomXVelocity: Int
        
        // Create a random X velocity(how far to move horizontally) that takes into account the enemy's position
        if randomPosition.x < 256 {
            randomXVelocity = Int.random(in: 8...15)
        } else if randomPosition.x < 512 {
            randomXVelocity = Int.random(in: 3...5)
        } else if randomPosition.x < 768 {
            randomXVelocity = -Int.random(in: 3...5)
        } else {
            randomXVelocity = -Int.random(in: 8...15)
        }
        
        // Create a random Y velocity just to make things fly at different speed
        let randomYVelocity = Int.random(in: 24...32)
        
        // Give all enemies a circular physics body where the collisionBitMask is set to 0 so that they don't collide
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: 64)
        enemy.physicsBody?.velocity = CGVector(dx: randomXVelocity * 40, dy: randomYVelocity * 40)
        enemy.physicsBody?.angularVelocity = randomAngularVelocity
        enemy.physicsBody?.collisionBitMask = 0
        
        
        addChild(enemy)
        activeEnemies.append(enemy)
    }
}

fileprivate enum GameSceneConstants {
    // Game Score
    static let gameScoreFontSize: CGFloat = 48
    static let gameScorePosition: CGPoint = CGPoint(x: 8, y: 8)
    
    // Live Images
    static let livesImageStartXPos = 880
    static let liveImagesStartYPos = 710
    static let liveImagesWidth = 70
    
    // Background
    static let backgroundPosition = CGPoint(x: 566.5, y: 372) // Tuts gives (x: 512, y: 384) but it doesn't center the background
    static let backgroundZPosition: CGFloat = -1
    
    // Gravity
    static let xGravity: CGFloat = 0
    static let yGravity: CGFloat = -0.6 // Earth's gravity is -0.98
    static let gravitySpeed = 0.85
}
