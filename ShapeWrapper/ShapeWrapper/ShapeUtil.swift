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
}