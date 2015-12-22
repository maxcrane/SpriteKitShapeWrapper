//
//  Emoji.swift
//  ShapeWrapper
//
//  Created by Max Crane on 12/20/15.
//  Copyright © 2015 Crane Apps. All rights reserved.
//

import Foundation
import SpriteKit

class Emoji: SKShapeNode {
    var anEmoji: SKLabelNode!
    var emojiConstraint: SKConstraint?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    init(aScene: SKScene, aPosition: CGPoint){
        //super.init(frame: aRect)
        super.init()
        let aDiameter = 28.0
        let theSize = CGSize(width: aDiameter, height: aDiameter)
        
        var emojiFace = String(UnicodeScalar(0x1F601))
        anEmoji = SKLabelNode(text: emojiFace)
        anEmoji?.name = "emojiLabel"
        anEmoji?.position = CGPoint(x: aPosition.x, y: aPosition.y - theSize.height/2)
        anEmoji?.zPosition = ZPositions.Emojis
        anEmoji?.horizontalAlignmentMode = .Center
        anEmoji?.verticalAlignmentMode = .Center
        aScene.addChild(anEmoji!)
        self.name = "emoji"
        
        
        
        let theOrigin = CGPoint(x: -aDiameter/2, y: -aDiameter/2)
        
        self.path = CGPathCreateWithEllipseInRect(CGRect(origin: theOrigin, size: theSize), nil)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(aDiameter/2.0))
        self.physicsBody?.categoryBitMask = CollisionCategories.Circle
        self.physicsBody?.contactTestBitMask = CollisionCategories.Box
        self.physicsBody?.collisionBitMask = ShapeUtil.collisionBitMasks()
        self.physicsBody?.affectedByGravity = false
        self.position = aPosition
        
        self.zPosition = ZPositions.Shapes
        self.strokeColor = SKColor.clearColor()
        self.fillColor = SKColor.clearColor()
        aScene.addChild(self)
        
        
        
//        for i in 0x1F601...0x1F64F {
//            var c = String(UnicodeScalar(i))
//            print(c)
//        }
        let alignTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "alignEmoji", userInfo: nil, repeats: true)
        alignTimer.fire()
        
    }
    
    
    func alignEmoji(){
        anEmoji?.position = CGPoint(x: self.position.x, y: self.position.y)// - self.frame.size.height/2)
    }
    
    func rotateBy(arc: CGFloat){
        self.zRotation += arc
        self.anEmoji.zRotation -= arc
    }
    
    func scaleBy(scale: CGFloat){
        let scaleAction = SKAction.scaleBy(scale, duration: 0.00000001)
        self.runAction(scaleAction)
        self.anEmoji.runAction(scaleAction)
    }
    
    
    
}