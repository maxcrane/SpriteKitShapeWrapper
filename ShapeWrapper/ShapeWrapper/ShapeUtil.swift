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
        
        if(aShape is Emoji){
            let emojiShape = aShape as! Emoji
            emojiShape.anEmoji.zRotation += arc
        }
    }
    
    static func handlePinch(scale: CGFloat, aShape: SKShapeNode){
        let scaleAction = SKAction.scaleBy(scale, duration: 0.00000001)
        aShape.runAction(scaleAction)
        
        if(aShape is Emoji){
            let emojiShape = aShape as! Emoji
            emojiShape.anEmoji.runAction(scaleAction)
        }
    }
    
    
    static func fadeOut(aShape: SKShapeNode){
        let fadeOutAction = SKAction.fadeAlphaTo(0.3, duration: 0.3)
        aShape.runAction(fadeOutAction)
    }
    
    static func fadeIn(aShape: SKShapeNode){
        let fadeInAction = SKAction.fadeAlphaTo(1, duration: 0.3)
        aShape.runAction(fadeInAction)
    }
    
    static func collisionBitMasks()->UInt32{
        return CollisionCategories.Border | CollisionCategories.Circle | CollisionCategories.Ellipse
            | CollisionCategories.Rectangle | CollisionCategories.Triangle
    }
}