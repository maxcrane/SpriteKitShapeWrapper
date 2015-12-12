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
    static let Triangle: UInt32 = 0x1 << 3
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    let shapeNames: [String] = ["rectangle", "circle", "triangle", "ellipse"]
    var selectedShape: SKShapeNode?

    override func didMoveToView(view: SKView) {
        configurePhysics()
        addButtons()
        self.name = "shapescene"
    }
    
    func configurePhysics(){
        //Get rid of gravity
        //self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.categoryBitMask = CollisionCategories.Border
    }
    
    func addButtons(){
        let addRectangle = SKLabelNode(text: "+rectangle")
        addRectangle.fontSize = 20
        addRectangle.name = "+rectangle"
        addRectangle.position = CGPoint(x: self.frame.midX - 70, y: self.frame.maxY - 40)
        addRectangle.color = SKColor.blackColor()
        self.addChild(addRectangle)
        
        let addCircle = SKLabelNode(text: "+circle")
        addCircle.fontSize = 20
        addCircle.name = "+circle"
        addCircle.position = CGPoint(x: self.frame.midX + 70, y: self.frame.maxY - 40)
        addCircle.color = SKColor.blackColor()
        self.addChild(addCircle)
        
        let addTriangle = SKLabelNode(text: "+triangle")
        addTriangle.fontSize = 20
        addTriangle.name = addTriangle.text
        addTriangle.position = CGPoint(x: self.frame.midX - 70, y: self.frame.maxY - 70)
        addTriangle.color = SKColor.blackColor()
        self.addChild(addTriangle)
        
        let addEllipse = SKLabelNode(text: "+ellipse")
        addEllipse.fontSize = 20
        addEllipse.name = addEllipse.text
        addEllipse.position = CGPoint(x: self.frame.midX + 70, y: self.frame.maxY - 70)
        addEllipse.color = SKColor.blackColor()
        self.addChild(addEllipse)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let touchedNode = self.nodeAtPoint(location)
            
            if(touchedNode.name == "+circle"){
                addCircleAtPoint(CGPoint(x: self.frame.midX, y: self.frame.midY))
            }
            else if(touchedNode.name == "+rectangle"){
                addRectAtPoint(CGPoint(x: self.frame.midX, y: self.frame.midY))
            }
            else if(touchedNode.name == "+triangle"){
                addTriangleAtPoint(CGPoint(x: self.frame.midX, y: self.frame.midY))
            }
            else if(touchedNode.name == "+ellipse"){
                addEllipseAtPoint(CGPoint(x: self.frame.midX, y: self.frame.midY))
            }
            else if(shapeNames.contains(touchedNode.name!)){
                selectedShape = touchedNode as? SKShapeNode
                ShapeUtil.highlight(selectedShape!)
            }
            else if(selectedShape != nil){
                ShapeUtil.unhighlight(selectedShape!)
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let location = touch.locationInNode(self)
    
            if(selectedShape != nil){
                selectedShape!.position = location
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
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
        let rect = Rectangle(aWidth: 100.0, aHeight: 50.0, aColor: SKColor.orangeColor())
        rect.position = aPoint
        self.addChild(rect)
    }
    
    func addEllipseAtPoint(aPoint: CGPoint){
        let ellipse = Ellipse(width: 100.0, height: 50.0, color: SKColor.orangeColor())
        ellipse.position = aPoint
        self.addChild(ellipse)
    }
    
    func addCircleAtPoint(aPoint:CGPoint){
        let circle = Circle(aDiameter: 50.0, aColor: SKColor.orangeColor())
        circle.position = aPoint
        self.addChild(circle)
    }
    
    func addTriangleAtPoint(aPoint:CGPoint){
        let triangle = Triangle(aSideLength: 50.0, aColor: SKColor.orangeColor())
        triangle.position = aPoint
        self.addChild(triangle)
    }
    

}
