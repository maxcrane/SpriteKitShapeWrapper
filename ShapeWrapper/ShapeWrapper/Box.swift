//
//  Bin.swift
//  ShapeWrapper
//
//  Created by Max Crane on 12/15/15.
//  Copyright © 2015 Crane Apps. All rights reserved.
//

import Foundation
import SpriteKit

class Box: SKShapeNode{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(aSideLength: CGFloat, aColor: SKColor){
        super.init()
        self.name = "box"
        
        let height = getHeight(aSideLength)
        
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: -height, y: 0))
        
        //add first line
        var nextPoint = CGPoint(x: 0, y: height)
        bezierPath.addLineToPoint(nextPoint)
        
        //add second line
        nextPoint = CGPoint(x: height, y: 0)
        bezierPath.addLineToPoint(nextPoint)
        
        //add third line
        nextPoint = CGPoint(x: 0, y: -height)
        bezierPath.addLineToPoint(nextPoint)
        
        //add fourth line
        bezierPath.closePath()
        
        self.path = bezierPath.CGPath
        self.physicsBody = SKPhysicsBody(polygonFromPath: bezierPath.CGPath)
        self.physicsBody?.categoryBitMask = CollisionCategories.Box
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.dynamic = false
        
        self.zPosition = ZPositions.Box
        self.strokeColor = SKColor.clearColor()
        self.fillColor = aColor
    }
    
    func getHeight(aSideLength: CGFloat)->CGFloat{
        return sqrt(pow(aSideLength, 2.0)/2.0)
    }
}