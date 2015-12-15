//
//  HingedRectangles.swift
//  ShapeWrapper
//
//  Created by Max Crane on 12/14/15.
//  Copyright © 2015 Crane Apps. All rights reserved.
//

import Foundation
import SpriteKit

class HingedRectangles: SKShapeNode{
    var rect1: SKShapeNode?
    var rect2: SKShapeNode?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(aWidth: CGFloat, aHeight: CGFloat, aColor: SKColor, aScene: SKScene, aPosition: CGPoint){
        super.init()
        rect1 = Rectangle(aWidth: aWidth, aHeight: aHeight, aColor: aColor, aPosition: aPosition)
        rect2 = Rectangle(aWidth: aWidth, aHeight: aHeight, aColor: aColor, aPosition: CGPoint(x: aPosition.x + aWidth, y: aPosition.y))
        rect1?.physicsBody?.dynamic = false
        
        aScene.addChild(rect1!)
        aScene.addChild(rect2!)
        
        var aJoint = SKPhysicsJointPin.jointWithBodyA((rect1?.physicsBody)!, bodyB: (rect2?.physicsBody)!, anchor: CGPoint(x: CGRectGetMaxX((rect1?.frame)!), y: CGRectGetMinY((rect1?.frame)!)))
        aJoint.shouldEnableLimits = true
        aJoint.lowerAngleLimit = degreesToRadians(-180)
        aJoint.upperAngleLimit = degreesToRadians(0)
        aScene.physicsWorld.addJoint(aJoint)
    }
    
    func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return CGFloat(M_PI) * degrees / 180.0
    }
}