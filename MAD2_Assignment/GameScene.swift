//
//  GameScene.swift
//  MAD2_Assignment
//
//  Created by Tristan Cheah on 16/1/20.
//  Copyright © 2020 Tristan Cheah. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    let player = SKSpriteNode(imageNamed: "player")
    let ball = SKSpriteNode(imageNamed: "joystick_ball")
    let base = SKSpriteNode(imageNamed: "joystick_base")
    
    var stickActive : Bool = false
    
    
    
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        player.position = CGPoint(x: 100, y: 100);
        player.scale(to: CGSize(width: 100, height: 100));
        self.addChild(player)
        
        self.addChild(base)
        base.position = CGPoint(x: 0, y: -200)
        base.scale(to: CGSize(width: 150, height: 150))
        
        self.addChild(ball)
        ball.position = base.position
        ball.scale(to: CGSize(width: 150, height: 150))
        
        base.alpha = 0.4
        ball.alpha = 0.4
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        
        for t in touches {
            
            let location = t.location(in: self)
            if(base.frame.contains(location)){
                stickActive = true
                walkingRight = false
                walkingLeft = false
            }
            else{
                stickActive = false
            }
            
        }
    }
    var walkingLeft:Bool = false
    var walkingRight:Bool = false
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in (touches as Set<UITouch>){
            let location = t.location(in: self)
            if(stickActive == true){
                let v = CGVector(dx: location.x - base.position.x, dy: location.y - base.position.y)
                
                let angle = atan2(v.dy, v.dx)
                let deg = (angle * CGFloat(180/Double.pi)) + 180
                
                let length:CGFloat = base.frame.size.height/2
                
                let x_dist:CGFloat = sin(angle - 1.57079633) * length
                let y_dist :CGFloat = cos(angle - 1.57079633) * length //90 ded in radians
                
                
                
                if(base.frame.contains(location)){
                    ball.position = location
                }
                else{
                    ball.position = CGPoint(x:base.position.x - x_dist, y:base.position.y + y_dist)
                }
                print(deg)
                if (deg < 90 || deg > 315){
                    
                    walkingLeft = true
                }
                else{
                    walkingLeft = false
                }
                
                if(deg < 225){
                    walkingRight = true
                }
                else{
                    walkingRight = false
                }
                
               
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            if (stickActive == true){
                let move:SKAction = SKAction.move(to: base.position, duration: 0.2)
                move.timingMode = .easeOut
                
                ball.run(move)
                walkingRight = false
                walkingLeft = false
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        if(walkingLeft == true){
            player.position.x -= 1;
        }
        else if (walkingRight == true){
            player.position.x += 1;
        }
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
