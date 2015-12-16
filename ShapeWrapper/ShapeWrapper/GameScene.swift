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
    static let Box: UInt32 = 0x1 << 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    let shapeNames: [String] = ["rectangle", "circle", "triangle", "ellipse"]
    var selectedShape: SKShapeNode?
    var shouldPanSelectedShape: Bool?
    
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
                
                if(selectedShape != nil && selectedShape != touchedShape){
                    deselectShape(selectedShape!)
                }
                selectShape(touchedShape!)
                shouldPanSelectedShape = true
            }
        }
    }
    
    func selectShape(shape: SKShapeNode){
        selectedShape = shape
        ShapeUtil.highlight(selectedShape!)
    }
    
    func deselectShape(shape: SKShapeNode){
        ShapeUtil.unhighlight(shape)
        selectedShape = nil
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        shouldPanSelectedShape = false
    }
    
//    func didBeginContact(contact: SKPhysicsContact) {
//        var bodyA = contact.bodyA
//        var bodyB = contact.bodyB
//        
//        if(bodyA.categoryBitMask > bodyB.categoryBitMask){
//            bodyA = contact.bodyB
//            bodyB = contact.bodyA
//        }
//        
//        if(bodyB.categoryBitMask == CollisionCategories.Box){
//            let bodyANode = bodyA.node as! SKShapeNode
//            ShapeUtil.fadeOut(bodyANode)
//        }
//    }
    
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
        print("handling pan")
        if(selectedShape != nil && shouldPanSelectedShape == true){
            print("handlded")
            selectedShape?.position = CGPoint(x: (selectedShape?.position.x)! + translation.x, y: (selectedShape?.position.y)! - translation.y)
        }
    }
    
    func handlePinch(scale: CGFloat){
        if(selectedShape != nil){
            let scaleAction = SKAction.scaleBy(scale, duration: 0.00000001)
            selectedShape?.runAction(scaleAction)
        }
    }
    
    func handleRotate(rotation: CGFloat){
        if(selectedShape != nil){
            ShapeUtil.rotateBy(-rotation, aShape: selectedShape!)
        }
    }

}
