//
//  GameScene.swift
//  acmGame
//
//  Created by Alex  Cowley on 1/29/19.
//  Copyright © 2019 Alex  Cowley. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let player = SKSpriteNode(imageNamed: "run01")
    var playerRunFrames = [SKTexture]()
    
    var playerScore = 0
    let scoreLabel = SKLabelNode()
    
    var highScore = 0
    let highScoreLabel = SKLabelNode()
    
    let PlayerCategory : UInt32 = 0x1 << 1
    let GroundCategory : UInt32 = 0x1 << 2
    let firstObsCategory : UInt32 = 0x1 << 3
    let secondObsCategory : UInt32 = 0x1 << 4
    let thirdObsCategory : UInt32 = 0x1 << 5
    let fourthObsCategory : UInt32 = 0x1 << 6
    
    //let cam = SKCameraNode()
    
    var firstObs = SKSpriteNode()
    
    var secondObs = SKSpriteNode()
    
    var thirdObs = SKSpriteNode()
    
    var fourthObs = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
//        self.camera = cam
//        self.addChild(cam)
//
//        let constraint = SKConstraint.distance(SKRange(constantValue: 0), to: player)
//        cam.constraints = [constraint]
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        physicsWorld.contactDelegate = self
        
        backgroundColor = SKColor.black
        
        let background = SKSpriteNode(imageNamed: "BGwithSun")
        let volcano = SKSpriteNode(imageNamed: "volcano")
    
        createGround()
        
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = -10
        
        addChild(background)
        
        volcano.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        volcano.position = CGPoint(x: 0, y: -200)
        volcano.zPosition = -9
        
        addChild(volcano)
        
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        player.zPosition = 0
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.restitution = 0
        player.physicsBody?.categoryBitMask = PlayerCategory
        player.physicsBody?.collisionBitMask = GroundCategory | firstObsCategory | secondObsCategory | thirdObsCategory | fourthObsCategory
        player.physicsBody?.contactTestBitMask = firstObsCategory | secondObsCategory | thirdObsCategory | fourthObsCategory
        player.name = "player"
        
        addChild(player)
        
        playerRun()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view!.addGestureRecognizer(swipeUp)
        
        scoreLabel.position = CGPoint(x: frame.midX - 800, y: frame.midY + 500)
        scoreLabel.zPosition = 1
        scoreLabel.fontColor = UIColor.black
        scoreLabel.fontSize = 100.0
        scoreLabel.fontName = "arial"
        scoreLabel.text = ("Score \(playerScore)")
        
        addChild(scoreLabel)
        
        highScoreLabel.position = CGPoint(x: frame.midX + 500, y: frame.midY + 500)
        highScoreLabel.zPosition = 1
        highScoreLabel.fontColor = UIColor.black
        highScoreLabel.fontSize = 100.0
        highScoreLabel.fontName = "arial"
        highScoreLabel.text = ("High Score \(highScore)")
        
        addChild(highScoreLabel)
        
        firstObs = SKSpriteNode(color: UIColor.red, size: CGSize(width: CGFloat.random(in: 50 ... 100), height: CGFloat.random(in: 100 ... 200)))
        firstObs.position = CGPoint(x: frame.maxX + 1000, y: frame.midY)
        firstObs.zPosition = 0
        firstObs.physicsBody = SKPhysicsBody(rectangleOf: firstObs.size)
        firstObs.physicsBody?.allowsRotation = false
        firstObs.physicsBody?.restitution = 0
        firstObs.physicsBody?.categoryBitMask = firstObsCategory
        firstObs.physicsBody?.collisionBitMask = GroundCategory | PlayerCategory
        firstObs.name = "firstObs"

        addChild(firstObs)
        
        secondObs = SKSpriteNode(color: UIColor.blue, size: CGSize(width: CGFloat.random(in: 100 ... 200), height: CGFloat.random(in: 50 ... 100)))
        secondObs.position = CGPoint(x: frame.maxX + 1500, y: frame.midY)
        secondObs.zPosition = 0
        secondObs.physicsBody = SKPhysicsBody(rectangleOf: secondObs.size)
        secondObs.physicsBody?.allowsRotation = false
        secondObs.physicsBody?.restitution = 0
        secondObs.physicsBody?.categoryBitMask = secondObsCategory
        secondObs.physicsBody?.collisionBitMask = GroundCategory | PlayerCategory
        secondObs.name = "secondObs"
        
        thirdObs = SKSpriteNode(color: UIColor.green, size: CGSize(width: CGFloat.random(in: 50 ... 100), height: 50))
        thirdObs.position = CGPoint(x: frame.maxX + 2000, y: frame.midY)
        thirdObs.zPosition = 0
        thirdObs.physicsBody = SKPhysicsBody(rectangleOf: secondObs.size)
        thirdObs.physicsBody?.allowsRotation = false
        thirdObs.physicsBody?.restitution = 0
        thirdObs.physicsBody?.affectedByGravity = false
        thirdObs.physicsBody?.categoryBitMask = thirdObsCategory
        thirdObs.physicsBody?.collisionBitMask = GroundCategory | PlayerCategory
        thirdObs.name = "thirdObs"
        
        fourthObs = SKSpriteNode(color: UIColor.purple, size: CGSize(width: CGFloat.random(in: 100 ... 300), height: CGFloat.random(in: 100 ... 300)))
        fourthObs.position = CGPoint(x: frame.maxX + 500, y: frame.midY)
        fourthObs.zPosition = 0
        fourthObs.physicsBody = SKPhysicsBody(rectangleOf: fourthObs.size)
        fourthObs.physicsBody?.allowsRotation = false
        fourthObs.physicsBody?.restitution = 0
        fourthObs.physicsBody?.categoryBitMask = fourthObsCategory
        fourthObs.physicsBody?.collisionBitMask = GroundCategory | PlayerCategory
        fourthObs.name = "fourthObs"
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveScene()
        scoreLabel.text = ("Score \(playerScore)")
        if playerScore > highScore {
            highScore = playerScore
            highScoreLabel.text = ("High Score \(highScore)")
        }
    }
    
    
    func createGround() {
        let Ground1 = SKSpriteNode(imageNamed: "ground")
        Ground1.name = "ground"
        Ground1.anchorPoint = CGPoint(x: 0, y: 0)
        Ground1.position = CGPoint(x: (-(self.scene?.size.width)!/2), y:  (-(self.scene?.size.height)!)/2)
        Ground1.zPosition = 0
        Ground1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1022, height: 806))
        Ground1.physicsBody?.affectedByGravity = false
        Ground1.physicsBody?.allowsRotation = false
        Ground1.physicsBody?.restitution = 0
        Ground1.physicsBody?.isDynamic = false
        Ground1.physicsBody?.categoryBitMask = GroundCategory
        Ground1.physicsBody?.collisionBitMask = PlayerCategory
        self.addChild(Ground1)
       
        
        for i in 0...4 {
            let Ground = SKSpriteNode(imageNamed: "ground")
            Ground.name = "ground"
            Ground.anchorPoint = CGPoint(x: 0, y: 0)
            Ground.position = CGPoint(x:  CGFloat(i) * ((self.scene?.size.width)!/2), y: (-(self.scene?.size.height)!)/2)
            Ground.zPosition = 0
            Ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1022, height: 806))
            Ground.physicsBody?.affectedByGravity = false
            Ground.physicsBody?.allowsRotation = false
            Ground.physicsBody?.restitution = 0
            Ground.physicsBody?.isDynamic = false
            Ground.physicsBody?.categoryBitMask = GroundCategory
            Ground.physicsBody?.collisionBitMask = PlayerCategory
            self.addChild(Ground)
        }
    }
    
    func moveScene() {
        self.enumerateChildNodes(withName: "ground") { (node, error) in
            node.position.x -= 20
            if node.position.x < -((self.scene?.size.width)!/2 + 1100) {
                node.position.x += ((self.scene?.size.width)! + 1100.0)
            }
        }
        
        firstObs.position.x -= 10
        if firstObs.position.x < frame.minX - 50 {
            playerScore += 1
            if playerScore == 5 {
                createBlueObs()
            }
            if playerScore == 10 {
                createGreenObs()
            }
            if playerScore == 20 {
                createPurpleObs()
            }
            firstObs.removeFromParent()
            resetObs()
        }
        
        if playerScore >= 5 {
            secondObs.position.x -= 15
            if secondObs.position.x < frame.minX - 100 {
                playerScore += 1
                if playerScore == 5 {
                    createBlueObs()
                }
                if playerScore == 10 {
                    createGreenObs()
                }
                if playerScore == 20 {
                    createPurpleObs()
                }
                secondObs.removeFromParent()
                createBlueObs()
            }
        }
        
        if playerScore >= 10 {
            thirdObs.position.x -= 20
            if thirdObs.position.x < frame.minX - 25 {
                playerScore += 1
                if playerScore == 5 {
                    createBlueObs()
                }
                if playerScore == 10 {
                    createGreenObs()
                }
                if playerScore == 20 {
                    createPurpleObs()
                }
                thirdObs.removeFromParent()
                createGreenObs()
            }
        }
        
        if playerScore >= 15 {
            fourthObs.position.x -= 5
            if fourthObs.position.x < frame.minX - 25 {
                playerScore += 1
                if playerScore == 5 {
                    createBlueObs()
                }
                if playerScore == 10 {
                    createGreenObs()
                }
                if playerScore == 20 {
                    createPurpleObs()
                }
                fourthObs.removeFromParent()
                createPurpleObs()
            }
        }
    }
    
    func playerRun() {
        let textureAtlasRunRight = SKTextureAtlas(named: "Run")
        for index in 1..<textureAtlasRunRight.textureNames.count {
            let textureName = "run0\(index)"
            playerRunFrames.append(textureAtlasRunRight.textureNamed(textureName))
        }
        player.run(SKAction.repeatForever(SKAction.animate(with: playerRunFrames, timePerFrame: 0.08)))
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
            case UISwipeGestureRecognizer.Direction.up:
                playerJump()
            default:
                break
            }
        }
    }
    
    func playerJump() {
        player.position.y += 200
    }
    
    func collision(_ node: SKSpriteNode,_ obs: SKSpriteNode) {
        if obs.name == "firstObs" || obs.name == "secondObs" || obs.name == "thirdObs" || obs.name == "fourthObs" {
            playerScore = 0
            firstObs.removeFromParent()
            secondObs.removeFromParent()
            thirdObs.removeFromParent()
            fourthObs.removeFromParent()
            resetObs()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node!.name == "player" {
            collision(contact.bodyA.node as! SKSpriteNode, contact.bodyB.node! as! SKSpriteNode)
        } else if contact.bodyB.node?.name == "player" {
            collision(contact.bodyB.node! as! SKSpriteNode, contact.bodyA.node! as! SKSpriteNode)
        }
    }
    
    func resetObs() {
        firstObs = SKSpriteNode(color: UIColor.red, size: CGSize(width: CGFloat.random(in: 50 ... 100), height: CGFloat.random(in: 100 ... 200)))
        firstObs.position = CGPoint(x: frame.maxX + 1000, y: frame.midY)
        firstObs.zPosition = 0
        firstObs.physicsBody = SKPhysicsBody(rectangleOf: firstObs.size)
        firstObs.physicsBody?.allowsRotation = false
        firstObs.physicsBody?.restitution = 0
        firstObs.physicsBody?.categoryBitMask = firstObsCategory
        firstObs.physicsBody?.collisionBitMask = GroundCategory | PlayerCategory
        firstObs.name = "firstObs"
        addChild(firstObs)
    }
    
    func createBlueObs() {
        secondObs = SKSpriteNode(color: UIColor.blue, size: CGSize(width: CGFloat.random(in: 100 ... 200), height: CGFloat.random(in: 50 ... 100)))
        secondObs.position = CGPoint(x: frame.maxX + 1500, y: frame.midY)
        secondObs.zPosition = 0
        secondObs.physicsBody = SKPhysicsBody(rectangleOf: secondObs.size)
        secondObs.physicsBody?.allowsRotation = false
        secondObs.physicsBody?.restitution = 0
        secondObs.physicsBody?.categoryBitMask = secondObsCategory
        secondObs.physicsBody?.collisionBitMask = GroundCategory | PlayerCategory
        secondObs.name = "secondObs"
        addChild(secondObs)
    }
    
    func createGreenObs() {
        thirdObs = SKSpriteNode(color: UIColor.green, size: CGSize(width: CGFloat.random(in: 50 ... 100), height: 50))
        thirdObs.position = CGPoint(x: frame.maxX + 2000, y: frame.midY)
        thirdObs.zPosition = 0
        thirdObs.physicsBody = SKPhysicsBody(rectangleOf: secondObs.size)
        thirdObs.physicsBody?.allowsRotation = false
        thirdObs.physicsBody?.restitution = 0
        thirdObs.physicsBody?.affectedByGravity = false
        thirdObs.physicsBody?.categoryBitMask = thirdObsCategory
        thirdObs.physicsBody?.collisionBitMask = GroundCategory | PlayerCategory
        thirdObs.name = "thirdObs"
        addChild(thirdObs)
    }
    
    func createPurpleObs() {
        fourthObs = SKSpriteNode(color: UIColor.purple, size: CGSize(width: CGFloat.random(in: 100 ... 300), height: CGFloat.random(in: 100 ... 300)))
        fourthObs.position = CGPoint(x: frame.maxX + 500, y: frame.midY)
        fourthObs.zPosition = 0
        fourthObs.physicsBody = SKPhysicsBody(rectangleOf: fourthObs.size)
        fourthObs.physicsBody?.allowsRotation = false
        fourthObs.physicsBody?.restitution = 0
        fourthObs.physicsBody?.categoryBitMask = fourthObsCategory
        fourthObs.physicsBody?.collisionBitMask = GroundCategory | PlayerCategory
        fourthObs.name = "fourthObs"
        addChild(fourthObs)
    }
}





