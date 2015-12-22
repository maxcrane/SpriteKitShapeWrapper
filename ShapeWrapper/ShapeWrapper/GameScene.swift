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
    static let Ellipse: UInt32 = 0x1 << 4
    static let Box: UInt32 = 0x1 << 5
    static let Emoji: UInt32 = 0x1 << 6
}

struct ZPositions{
    static let Shapes:CGFloat = 1.0
    static let Box:CGFloat = 2.0
    static let Emojis:CGFloat = 3.0
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    let shapeNames: [String] = ["rectangle", "circle", "triangle", "ellipse"]
    var selectedShape: SKShapeNode?
    var selectedNode: SKSpriteNode?
    var shouldPanSelectedShape: Bool?
    var shouldDeleteShape: Bool?
    
    override func didMoveToView(view: SKView) {
        configurePhysics()
        addButtons()
        addEmoji()  
        self.name = "shapescene"
        shouldDeleteShape = false
    }
    
    func configurePhysics(){
        //Get rid of gravity
        //self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.categoryBitMask = CollisionCategories.Border
    }
    
    func addEmoji(){
        //let emoji = Emoji(aScene: self, aPosition: CGPoint(x: self.frame.midX, y: self.frame.midY))
        let emoji = Emoji()
        emoji.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(emoji)
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
        
        let addJoint = SKLabelNode(text: "+joint")
        addJoint.fontSize = 20
        addJoint.name = addJoint.text
        addJoint.position = CGPoint(x: self.frame.midX + 70, y: self.frame.maxY - 100)
        addJoint.color = SKColor.blackColor()
        self.addChild(addJoint)
        
        let box = Box(aSideLength: 25.0, aColor: SKColor.whiteColor())
        box.position = CGPoint(x: self.frame.midX - 70, y: self.frame.maxY - 100)
        self.addChild(box)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

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
            else if(touchedNode.name == "+joint"){
                addHingedRectAtPoint(CGPoint(x: self.frame.midX, y: self.frame.midY))
            }
            else if(shapeNames.contains(touchedNode.name!)){
                let touchedShape = touchedNode as? SKShapeNode
                selectShape(touchedShape!)
            }
            else if(touchedNode.name == "emoji"){
                if(selectedShape != nil){
                    deselectShape(selectedShape!)
                }
                selectedNode = touchedNode as! SKSpriteNode
            }
        }
    }
    
    func selectShape(touchedShape: SKShapeNode){
        if(selectedShape != nil && selectedShape != touchedShape){
            deselectShape(selectedShape!)
        }
        selectedShape = touchedShape
        ShapeUtil.highlight(selectedShape!)
        selectedNode = nil
        shouldPanSelectedShape = true
    }
    
    func deselectShape(shape: SKShapeNode){
        ShapeUtil.unhighlight(shape)
        selectedShape = nil
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //shouldPanSelectedShape = false
        //print("touches ended")
    }
    
    func touchEndedAtPoint(point: CGPoint){
        shouldPanSelectedShape = false
        if(shouldDeleteShape == true && selectedShape != nil){
            self.removeChildrenInArray([selectedShape!])
            selectedShape = nil
            shouldDeleteShape = false
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        
        if(bodyA.categoryBitMask > bodyB.categoryBitMask){
            bodyA = bodyB
            bodyB = contact.bodyA
        }
        
        if(bodyB.categoryBitMask == CollisionCategories.Box){
            let bodyANode = bodyA.node as! SKShapeNode
            ShapeUtil.fadeOut(bodyANode)
            shouldDeleteShape = true
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        
        if(bodyA.categoryBitMask > bodyB.categoryBitMask){
            bodyA = bodyB
            bodyB = contact.bodyA
        }
        
        if(bodyB.categoryBitMask == CollisionCategories.Box){
            let bodyANode = bodyA.node as! SKShapeNode
            ShapeUtil.fadeIn(bodyANode)
            shouldDeleteShape = false
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
    
    func addHingedRectAtPoint(aPoint: CGPoint){
        let hingedRects = HingedRectangles(aWidth: 100.0, aHeight: 50.0, aColor: SKColor.orangeColor(), aScene: self, aPosition: aPoint)
    }
    
    func getVectorFromPoints(firstPoint: CGPoint, secondPoint: CGPoint)->CGVector{
        let dy = secondPoint.y - firstPoint.y
        let dx = secondPoint.x - firstPoint.x
        return CGVector(dx: dx, dy: dy)
    }
    
    func handlePan(translation: CGPoint){
        if(selectedShape != nil && shouldPanSelectedShape == true){
            selectedShape?.position = CGPoint(x: (selectedShape?.position.x)! + translation.x, y: (selectedShape?.position.y)! - translation.y)
        }
        if(selectedNode != nil){
            selectedNode?.position = CGPoint(x: (selectedNode?.position.x)! + translation.x, y: (selectedNode?.position.y)! - translation.y)
        }
    }
    
    func handlePinch(scale: CGFloat){
        if(selectedShape != nil){
            ShapeUtil.handlePinch(scale, aNode: selectedShape!)
        }
        if(selectedNode != nil){
            ShapeUtil.handlePinch(scale, aNode: selectedNode!)
        }
    }
    
    func handleRotate(rotation: CGFloat){
        if(selectedShape != nil){
            ShapeUtil.rotateBy(-rotation, aNode: selectedShape!)
        }
        if(selectedNode != nil){
            ShapeUtil.rotateBy(-rotation, aNode: selectedNode!)
        }
    }

}
