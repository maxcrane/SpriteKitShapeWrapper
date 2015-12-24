//
//  EmojiFromText.swift
//  ShapeWrapper
//
//  Created by Max Crane on 12/21/15.
//  Copyright © 2015 Crane Apps. All rights reserved.
//

import Foundation
import SpriteKit

class Emoji: SKSpriteNode {
    //var actualEmoji: SKSpriteNode?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(anEmoji: UInt32, aSize: CGFloat){
        let someString = String(UnicodeScalar(anEmoji))
        let someSize = CGSize(width: aSize, height: aSize)
        let theImage = Emoji.getImageFromString(someString, imageSize: someSize)
        let texture = SKTexture(image: theImage)
        super.init(texture: texture, color: SKColor.clearColor(), size: someSize)
        self.physicsBody = SKPhysicsBody(texture: texture, size: someSize)
        self.physicsBody?.categoryBitMask = CollisionCategories.Emoji
        self.physicsBody?.collisionBitMask = ShapeUtil.collisionBitMasks()
        self.physicsBody?.dynamic = false
        self.name = "emoji"
    }
    
    static func getImageFromString(someString: String, imageSize: CGSize)->UIImage{
        let origin = CGPoint(x: 0, y: 0)
        let rect = CGRect(origin: origin, size: imageSize)
        let textColor:UIColor =  UIColor.blackColor()
        let textFont: UIFont = UIFont(name: "Helvetica Bold", size: imageSize.height)!
        
        UIGraphicsBeginImageContext(imageSize)
        let textFontAtts = [NSFontAttributeName: textFont, NSForegroundColorAttributeName: textColor]
        someString.drawInRect(rect, withAttributes: textFontAtts)
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}