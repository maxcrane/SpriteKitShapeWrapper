//
//  Circle.swift
//  ShapeWrapper
//
//  Created by Max Crane on 12/7/15.
//  Copyright © 2015 Crane Apps. All rights reserved.
//

import Foundation
import SpriteKit

class Circle: SKShapeNode {
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        
    }
    
    init(aDiameter: Double, aColor: SKColor){
        super.init()
        self.name = "circle"
        
        let theOrigin = CGPoint(x: -aDiameter/2, y: -aDiameter/2)
        let theSize = CGSize(width: aDiameter, height: aDiameter)
        self.path = CGPathCreateWithEllipseInRect(CGRect(origin: theOrigin, size: theSize), nil)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(aDiameter/2.0))
        self.physicsBody?.categoryBitMask = CollisionCategories.Circle
        self.physicsBody?.affectedByGravity = true
        
        self.strokeColor = SKColor.clearColor() 
        self.fillColor = aColor
    }
}