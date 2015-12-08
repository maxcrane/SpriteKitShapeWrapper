//
//  GameScene.swift
//  ShapeWrapper
//
//  Created by Max Crane on 12/6/15.
//  Copyright (c) 2015 Crane Apps. All rights reserved.
//

import SpriteKit

struct CollisionCategories{
    static let Border: UInt32 = 0x1
    static let Rectangle: UInt32 = 0x1 << 1
    static let Circle: UInt32 = 0x1 << 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    override func didMoveToView(view: SKView) {
        configurePhysics()
        addButtons()
    }
    
    func configurePhysics(){
        //Get rid of gravity
        //self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.categoryBitMask = CollisionCategories.Border
    }
    
    func addButtons(){
        let rotateLeft = SKLabelNode(text: "rotate left")
        rotateLeft.fontSize = 20
        rotateLeft.name = "rotateL"
        rotateLeft.position = CGPoint(x: self.frame.midX - 70, y: self.frame.maxY - 40)
        rotateLeft.color = SKColor.blackColor()
        self.addChild(rotateLeft)
        
        let rotateRight = SKLabelNode(text: "rotate right")
        rotateRight.fontSize = 20
        rotateRight.name = "rotateR"
        rotateRight.position = CGPoint(x: self.frame.midX + 70, y: self.frame.maxY - 40)
        rotateRight.color = SKColor.blackColor()
        self.addChild(rotateRight)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let touchedNode = self.nodeAtPoint(location)
            
            if(touchedNode.name == "rotateL"){
                rotateLeft()
            }else if(touchedNode.name == "rotateR"){
                
            }
            else{
                addCircleAtPoint(location)
                //addRectAtPoint(location)
            }
        }
    }
    
    func rotateLeft(){
        self.enumerateChildNodesWithName("rectangle"){
            node, stop in
            node.zRotation = node.zRotation + CGFloat(M_1_PI)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func addRectAtPoint(aPoint: CGPoint){
        let rect = Rectangle(aSize: CGSize(width: 100.0, height: 50.0), aColor: SKColor.blackColor())
        rect.position = aPoint
        self.addChild(rect)
    }
    
    func addCircleAtPoint(aPoint:CGPoint){
        let circle = Circle(aDiameter: 50.0, aColor: SKColor.orangeColor())
        circle.position = aPoint
        self.addChild(circle)
    }
    

}
