//
//  Emoji.swift
//  ShapeWrapper
//
//  Created by Max Crane on 12/20/15.
//  Copyright © 2015 Crane Apps. All rights reserved.
//

import Foundation
import SpriteKit

class Emoji: SKLabelNode {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(){
        //super.init(frame: aRect)
        super.init()    
        self.text = "U+1F604";
        
    }
    
}