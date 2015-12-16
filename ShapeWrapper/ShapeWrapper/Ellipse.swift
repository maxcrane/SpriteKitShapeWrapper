//
//  Oval.swift
//  ShapeWrapper
//
//  Created by Max Crane on 12/10/15.
//  Copyright © 2015 Crane Apps. All rights reserved.
//

import Foundation
import SpriteKit

class Ellipse: SKShapeNode{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(width: CGFloat, height: CGFloat, color: SKColor){
        super.init()
        self.name = "ellipse"
        
        let rect = CGRect(x: -width/2.0, y: -height/2.0, width: width, height: height)
        let path = CGPathCreateWithEllipseInRect(rect, nil)
        self.path = path
        self.physicsBody = SKPhysicsBody(polygonFromPath: path)
        self.physicsBody?.categoryBitMask = CollisionCategories.Rectangle
        self.physicsBody?.contactTestBitMask = CollisionCategories.Box
        self.physicsBody?.affectedByGravity = false
        
        self.strokeColor = SKColor.clearColor() 
        self.fillColor = color
    }
}