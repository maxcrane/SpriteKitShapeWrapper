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
    
    init(aSize: CGSize, aColor: SKColor){
        super.init()
        self.name = "rectangle"
        
        let theOrigin = CGPoint(x: -aSize.width/2, y: -aSize.height/2)
        let rect = CGRect(origin: theOrigin, size: aSize)
        self.path = CGPathCreateWithRect(rect, nil)
        
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: aSize)
        self.physicsBody?.categoryBitMask = CollisionCategories.Rectangle
        self.physicsBody?.affectedByGravity = false
        
        self.fillColor = aColor
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
}