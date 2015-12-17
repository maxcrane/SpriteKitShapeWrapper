//
//  GameViewController.swift
//  ShapeWrapper
//
//  Created by Max Crane on 12/6/15.
//  Copyright (c) 2015 Crane Apps. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, UIGestureRecognizerDelegate {
    var skView: SKView!
    var scene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsPhysics = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .ResizeFill///.AspectFill
           
            self.scene = scene
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer){
        let translation = recognizer.translationInView(self.view)
        scene.handlePan(translation)
        recognizer.setTranslation(CGPointZero, inView: self.view)
        
        if(recognizer.state == UIGestureRecognizerState.Ended){
            let touchPoint: CGPoint = recognizer.locationInView(self.view)
            scene.touchEndedAtPoint(touchPoint)
        }
    }
    
    @IBAction func handlePinch(recognizer: UIPinchGestureRecognizer){
        scene.handlePinch(recognizer.scale)
        recognizer.scale = 1
    }
    
    @IBAction func handleRotate(recognizer: UIRotationGestureRecognizer){
        scene.handleRotate(recognizer.rotation)
        recognizer.rotation = 0
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
