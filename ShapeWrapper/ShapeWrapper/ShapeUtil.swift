//
//  ShapeUtil.swift
//  ShapeWrapper
//
//  Created by Max Crane on 12/8/15.
//  Copyright © 2015 Crane Apps. All rights reserved.
//

import Foundation
import SpriteKit

class ShapeUtil {
    
    static func highlight(aShape: SKShapeNode){
        aShape.strokeColor = SKColor.blackColor()
        aShape.lineWidth = 5
    }
    
    static func unhighlight(aShape: SKShapeNode){
        aShape.strokeColor = SKColor.clearColor()
    }
    
    static func rotateBy(arc: CGFloat, aShape: SKShapeNode){
        aShape.zRotation += arc
        
    }
    
    static func rotateFromVectors(var v1: CGVector, var v2: CGVector, aShape: SKShapeNode){
        if(v1.dx < 0 && v2.dx > 0){
            v1.dx = -v1.dx
        }
        else if(v1.dx > 0 && v2.dx < 0){
            v2.dx = -v2.dx
        }
        
        let firstAngle = atan(v1.dy/v1.dx)
        let secondAngle = atan(v2.dy/v2.dx)
        let angleDifference = secondAngle - firstAngle

        rotateBy(angleDifference, aShape: aShape)
    }
    
    static func scaleFromVectors( v1: CGVector,  v2: CGVector, aShape: SKShapeNode){
        let v1Length = sqrt(pow(v1.dx, 2.0) + pow(v1.dy, 2.0))
        let v2Length = sqrt(pow(v2.dx, 2.0) + pow(v2.dy, 2.0))
        let lengthDiff = v2Length - v1Length
        var scaleDiff = 0.0
        
        if(lengthDiff > 0){
            scaleDiff = 0.1
        }
        else{
            scaleDiff = -0.1
        }
        
        aShape.setScale(CGFloat(1.0 + scaleDiff))
    }
    
    static func fadeOut(aShape: SKShapeNode){
        let fadeOutAction = SKAction.fadeAlphaTo(0.5, duration: 0.3)
        aShape.runAction(fadeOutAction)
    }
    
    static func fadeIn(aShape: SKShapeNode){
        let fadeInAction = SKAction.fadeAlphaTo(1, duration: 0.3)
        aShape.runAction(fadeInAction)
    }
}