//
//  GameScene.swift
//  BounceSpriteKit2
//
//  Created by Larry Holder on 4/4/17.
//  Copyright © 2017 Larry Holder. All rights reserved.
//  NOTE: Homework eleven and twelve is built upon the code we did in lecture.

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate
{    
    var redBallNode: SKSpriteNode!
    var startStopLabel: SKLabelNode!
    var bounceSoundAction: SKAction!
    var glassBreakAction: SKAction!
    var screenPhysicsBody: SKPhysicsBody!
    var audioPlayer: AVAudioPlayer!
    var settingsNode: SKSpriteNode!
    var gameVC: GameViewController!
    
    override func didMove(to view: SKView)
    {
        // Make walls bouncy
        screenPhysicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        screenPhysicsBody.friction = 0.0
        screenPhysicsBody.categoryBitMask = 0b100
        self.physicsBody = screenPhysicsBody
        
        redBallNode = self.childNode(withName: "RedBall") as! SKSpriteNode
        startStopLabel = self.childNode(withName: "StartStop") as! SKLabelNode
        
        // for red ball and wall collisions
        screenPhysicsBody.contactTestBitMask = (redBallNode.physicsBody?.categoryBitMask)!
        
        bounceSoundAction = SKAction.playSoundFileNamed("bounce.mp3",
                                                        waitForCompletion: false)
        glassBreakAction = SKAction.playSoundFileNamed("glassbreak.mp3",
                                                        waitForCompletion: false)
        
        let musicURL = Bundle.main.url(forResource: "WSU-Fight-Song.mp3",
                                       withExtension: nil)
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: musicURL!)
        }
        catch
        {
            print("error accessing music")
        }
        audioPlayer.volume = 0.25
        audioPlayer.numberOfLoops = -1 // loop forever
        
        physicsWorld.contactDelegate = self
        
        // add the settings gear
        settingsNode = SKSpriteNode(imageNamed: "settings.png")
        settingsNode.name = "Settings"
        settingsNode.position.x = 300
        settingsNode.position.y = -580
        self.addChild(settingsNode)
        
        // move the start/stop label
        startStopLabel.position.x = -300
        startStopLabel.position.y = -600
        
        // itialize settings for the sound and music
        if (UserDefaults.standard.object(forKey: "sound") == nil)
        {
            UserDefaults.standard.set(true, forKey: "sound")
        }
        
        if (UserDefaults.standard.object(forKey: "music") == nil)
        {
            UserDefaults.standard.set(true, forKey: "music")
        }
    }
    
    func startGame ()
    {
        self.isPaused = false
        self.startStopLabel.text = "Stop"
        redBallNode.physicsBody?.applyImpulse(CGVector(dx: 200.0, dy: 200.0))
        self.playMusic()
    }
    
    func pauseGame ()
    {
        self.isPaused = true
        self.startStopLabel.text = "Start"
        audioPlayer.pause()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        var touchOnGreen = false
        
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
                
                if node.name == "Settings"
                {
                    self.view!.window!.rootViewController!.performSegue(withIdentifier: "toSettings", sender: self)
                }
                
                if node.name == "GreenBall"
                {
                    touchOnGreen = true
                    print ("touch on green ball")
                }
            }
            
            // don't add green balls directly on the startStopLabel
            // or the red ball
            if (!startStopLabel.contains(point) &&
                !redBallNode.contains(point) &&
                !settingsNode.contains(point) &&
                touchOnGreen == false)
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
        
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        if (nodeA!.name == "RedBall" && nodeB!.name == "GreenBall")
        {
            // manually calculating the resulting velocity after a green ball collision
            // algorithm from http://ericleong.me/research/circle-circle/#dynamic-static-circle-collision-response
            let dx = (nodeA?.position.x)! - (nodeB?.position.x)!
            let dy = (nodeA?.position.y)! - (nodeB?.position.y)!
            let distance = sqrt(dx * dx + dy * dy)
            
            let nx = dx / distance
            let ny = dy / distance
            let p = 2 * ((nodeA?.physicsBody?.velocity.dx)! * nx + (nodeA?.physicsBody?.velocity.dy)! * ny)
            
            // set the new velocity for the red ball
            nodeA?.physicsBody?.velocity.dx = (nodeA?.physicsBody?.velocity.dx)! - p * nx
            nodeA?.physicsBody?.velocity.dy = (nodeA?.physicsBody?.velocity.dy)! - p * ny
            
            print("Contact: \(bodyNameA), \(bodyNameB)")
            
            self.playGlassSound()
            
            // remove the green ball
            nodeB?.removeFromParent()
        }
        else if (nodeA!.name != "RedBall" && nodeB!.name != "GreenBall")
        {
            print("wall contact")
            self.playBounceSound()
        }
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
    }
    
    func playMusic ()
    {
        // check if we're allowed to play music first
        if (UserDefaults.standard.bool(forKey: "music") == true)
        {
            audioPlayer.play()
        }
    }
    
    func pauseMusic ()
    {
        audioPlayer.pause()
    }
    
    func playBounceSound ()
    {
        // check if we're allowed to play sounds first
        if (UserDefaults.standard.bool(forKey: "sound") == true)
        {
            run (bounceSoundAction)
        }
    }
    
    func playGlassSound ()
    {
        // check if we're allowed to play sounds first
        if (UserDefaults.standard.bool(forKey: "sound") == true)
        {
            run (glassBreakAction)
        }
    }
}
