//
//  Rectangle.swift
//  ShapeWrapper
//
//  Created by Max Crane on 12/6/15.
//  Copyright © 2015 Crane Apps. All rights reserved.
//

import Foundation
import SpriteKit

class Rectangle: SKShapeNode {
    
    init(aWidth: CGFloat, aHeight: CGFloat, aColor: SKColor){
        super.init()
        self.name = "rectangle"
        
        let aSize = CGSize(width: aWidth, height: aHeight)
        let theOrigin = CGPoint(x: -aSize.width/2, y: -aSize.height/2)
        let rect = CGRect(origin: theOrigin, size: aSize)
        self.path = CGPathCreateWithRect(rect, nil)
        
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: aSize)
        self.physicsBody?.categoryBitMask = CollisionCategories.Rectangle
        self.physicsBody?.contactTestBitMask = CollisionCategories.Box
        self.physicsBody?.collisionBitMask = ShapeUtil.collisionBitMasks()
        self.physicsBody?.affectedByGravity = false
        
        self.strokeColor = SKColor.clearColor() 
        self.fillColor = aColor
    }
    
    init(aWidth: CGFloat, aHeight: CGFloat, aColor: SKColor, aPosition: CGPoint){
        super.init()
        self.position = aPosition
        self.name = "rectangle"
        
        let aSize = CGSize(width: aWidth, height: aHeight)
        let theOrigin = CGPoint(x: -aSize.width/2, y: -aSize.height/2)
        let rect = CGRect(origin: theOrigin, size: aSize)
        self.path = CGPathCreateWithRect(rect, nil)
        
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: aSize)
        self.physicsBody?.categoryBitMask = CollisionCategories.Rectangle
        self.physicsBody?.affectedByGravity = false
        
        self.strokeColor = SKColor.clearColor()
        self.fillColor = aColor
        
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
}