//
//  Triangle.swift
//  ShapeWrapper
//
//  Created by Max Crane on 12/9/15.
//  Copyright © 2015 Crane Apps. All rights reserved.
//  Use this: https://developer.apple.com/library/ios/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/BezierPaths/BezierPaths.html

import Foundation
import SpriteKit

class Triangle: SKShapeNode {
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        
    }
    
    init(aSideLength: Double, aColor: SKColor){
        super.init()
        self.name = "Triangle"
        
        let bezierPath = UIBezierPath()
        bezierPath.addLineToPoint(CGPointZero)
        
        //add first line
        var nextPoint = CGPoint(x: aSideLength, y: 0)
        bezierPath.addLineToPoint(nextPoint)
        
        //add second line
        nextPoint = CGPoint(x: aSideLength/2, y: 50)
        bezierPath.addLineToPoint(nextPoint)
        
        //add third line
        bezierPath.addLineToPoint(CGPointZero)
        
        self.path = bezierPath.CGPath
        self.physicsBody = SKPhysicsBody(edgeLoopFromPath: self.path!)
        self.physicsBody?.categoryBitMask = CollisionCategories.Triangle
        self.physicsBody?.affectedByGravity = false
        self.fillColor = aColor
    }
}