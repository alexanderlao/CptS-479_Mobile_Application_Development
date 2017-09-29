//
//  GameScene.swift
//  BounceSpriteKit2
//
//  Created by Larry Holder on 4/4/17.
//  Copyright © 2017 Larry Holder. All rights reserved.
//  NOTE: Homework eleven is built upon the code we did in lecture.

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{    
    var redBallNode: SKSpriteNode!
    var startStopLabel: SKLabelNode!
    
    override func didMove(to view: SKView)
    {
        // Make walls bouncy
        let screenPhysicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        screenPhysicsBody.friction = 0.0
        screenPhysicsBody.categoryBitMask = 0b100
        self.physicsBody = screenPhysicsBody
        
        redBallNode = self.childNode(withName: "RedBall") as! SKSpriteNode
        startStopLabel = self.childNode(withName: "StartStop") as! SKLabelNode
        
        physicsWorld.contactDelegate = self
    }
    
    func startGame ()
    {
        self.isPaused = false
        self.startStopLabel.text = "Stop"
        redBallNode.physicsBody?.applyImpulse(CGVector(dx: 200.0, dy: 200.0))
    }
    
    func pauseGame ()
    {
        self.isPaused = true
        self.startStopLabel.text = "Start"
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let point = touch.location(in: self)
            let nodeArray = nodes(at: point)
            for node in nodeArray
            {
                if node.name == "StartStop"
                {
                    if (self.isPaused)
                    {
                        self.startGame()
                    }
                    else
                    {
                        self.pauseGame()
                    }
                }
            }
            
            // don't add green balls directly on the startStopLabel
            // or the red ball
            if (!startStopLabel.contains(point) &&
                !redBallNode.contains(point))
            {
                // add a new green ball
                let newGreenBallNode = SKSpriteNode(imageNamed: "greenball.png")
                newGreenBallNode.position = point
                newGreenBallNode.name = "GreenBall"
                newGreenBallNode.physicsBody = SKPhysicsBody(circleOfRadius: 50.0)
                newGreenBallNode.physicsBody?.affectedByGravity = false
                newGreenBallNode.physicsBody?.friction = 0.0
                newGreenBallNode.physicsBody?.restitution = 1.0
                newGreenBallNode.physicsBody?.linearDamping = 0.0
                newGreenBallNode.physicsBody?.categoryBitMask = 0b001
                newGreenBallNode.physicsBody?.collisionBitMask = 0b110
                newGreenBallNode.physicsBody?.contactTestBitMask = 0b001
                self.addChild(newGreenBallNode)
            }
        }
    }

    func didBegin(_ contact: SKPhysicsContact)
    {
        let bodyNameA = String(describing: contact.bodyA.node?.name)
        let bodyNameB = String(describing: contact.bodyB.node?.name)
        let nodeArray = nodes(at: (contact.bodyB.node?.position)!)
        
        let redBall = contact.bodyA.node
        let greenBall = contact.bodyB.node
        
        // manually calculating the resulting velocity after a green ball collision
        // algorithm from http://ericleong.me/research/circle-circle/#dynamic-static-circle-collision-response
        let dx = (redBall?.position.x)! - (greenBall?.position.x)!
        let dy = (redBall?.position.y)! - (greenBall?.position.y)!
        let distance = sqrt(dx * dx + dy * dy)
        
        let nx = dx / distance
        let ny = dy / distance
        let p = 2 * ((redBall?.physicsBody?.velocity.dx)! * nx + (redBall?.physicsBody?.velocity.dy)! * ny)
        
        // set the new velocity for the red ball
        redBall?.physicsBody?.velocity.dx = (redBall?.physicsBody?.velocity.dx)! - p * nx
        redBall?.physicsBody?.velocity.dy = (redBall?.physicsBody?.velocity.dy)! - p * ny
        
        print("Contact: \(bodyNameA), \(bodyNameB)")
        
        // remove the green ball
        self.removeChildren(in: nodeArray)
    }

    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
    }
}
