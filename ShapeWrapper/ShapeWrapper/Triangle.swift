//
//  Triangle.swift
//  ShapeWrapper
//  Makes an equilateral triangle with a given side length

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
        self.name = "triangle"
        
        let height = getHeight(aSideLength)
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: -aSideLength/2.0, y: -height/2.0))
        
        //add first line
        var nextPoint = CGPoint(x: aSideLength/2, y: -height/2.0)
        bezierPath.addLineToPoint(nextPoint)
        
        //add second line
        nextPoint = CGPoint(x: 0, y: height/2)
        bezierPath.addLineToPoint(nextPoint)
        
        //add third line
        bezierPath.closePath()
        
        self.path = bezierPath.CGPath
        self.physicsBody = SKPhysicsBody(polygonFromPath: bezierPath.CGPath)
        self.physicsBody?.categoryBitMask = CollisionCategories.Triangle
        self.physicsBody?.contactTestBitMask = CollisionCategories.Box
        self.physicsBody?.collisionBitMask = ShapeUtil.collisionBitMasks()
        self.physicsBody?.affectedByGravity = false
        
        self.strokeColor = SKColor.clearColor() 
        self.fillColor = aColor
    }
    
    func getHeight(aSideLength: Double)->Double{
        return aSideLength * sqrt(3) * 0.5
    }
}