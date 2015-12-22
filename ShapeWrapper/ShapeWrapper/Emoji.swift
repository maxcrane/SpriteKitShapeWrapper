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
    var anEmoji: SKLabelNode?
    var emojiConstraint: SKConstraint?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    init(aScene: SKScene, aPosition: CGPoint){
        //super.init(frame: aRect)
        super.init()
        let aDiameter = 50.0
        
        var emojiFace = String(UnicodeScalar(0x1F601))
        anEmoji = SKLabelNode(text: emojiFace)
        anEmoji?.name = "emojiLabel"
        anEmoji?.position = aPosition
        aScene.addChild(anEmoji!)
        self.name = "emoji"
        
         
        
        let theOrigin = CGPoint(x: -aDiameter/2, y: -aDiameter/2)
        let theSize = CGSize(width: aDiameter, height: aDiameter)
        self.path = CGPathCreateWithEllipseInRect(CGRect(origin: theOrigin, size: theSize), nil)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(aDiameter/2.0))
        self.physicsBody?.categoryBitMask = CollisionCategories.Circle
        self.physicsBody?.contactTestBitMask = CollisionCategories.Box
        self.physicsBody?.collisionBitMask = ShapeUtil.collisionBitMasks()
        self.physicsBody?.affectedByGravity = false
        self.position = aPosition
        
        self.zPosition = ZPositions.Shapes
        self.strokeColor = SKColor.clearColor()
        self.fillColor = SKColor.blackColor()
        aScene.addChild(self)
        
        let range = SKRange(value: 0.0, variance: 0.0)
        emojiConstraint = SKConstraint.distance(range, toNode: anEmoji!)
        self.constraints = [emojiConstraint!]
        //
        
        
//        for i in 0x1F601...0x1F64F {
//            var c = String(UnicodeScalar(i))
//            print(c)
//        }
    }
    
}