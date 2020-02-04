//
//  PlayerNode.swift
//  MAD2_Assignment
//
//  Created by Tristan Cheah on 24/1/20.
//  Copyright © 2020 Tristan Cheah. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
class PlayerNode : SKSpriteNode {
    
    var current_Scene :SKScene = SKScene()
    var stateMachine :GKStateMachine?
    var stickActive : Bool = false
    
    var speed_ : CGFloat = 0.0
    var grounded : Bool = false
    var landed : Bool = false
    var jump : Bool = false
    var walkingLeft : Bool = false
    var walkingRight : Bool = false
   
    var can_jump : Bool = false
    
    
    var airAccel : CGFloat = 0.1
    var airDecel : CGFloat = 0.1
    
    var groundAccel : CGFloat = 0.3
    var groundDecel : CGFloat = 0.5
    
    var max_jump : CGFloat = 300;
    
    var did_shoot : Bool = false;
    var player_state_name : String = "";
    
    func InstantiatePlayer(player : PlayerNode){
        
        player.position = CGPoint(x: 100, y: -200);
        setupStateMachine()
        player.scale(to: CGSize(width: 100, height: 100));
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        player.physicsBody?.restitution = 0.0 //stops player from bouncing
        player.physicsBody?.collisionBitMask = 2
        player.physicsBody?.categoryBitMask = 1
        player.physicsBody?.fieldBitMask = 0
        player.physicsBody?.contactTestBitMask = 0
        player.physicsBody?.allowsRotation = false
        player.name = "player"
        
    }
    
    func setupStateMachine(){
        let humanState = HumanState(player_node_: self)
        let catState = CatState(player_node_: self)
        stateMachine = GKStateMachine(states: [humanState, catState])
        stateMachine!.enter(HumanState.self)
        
    }
    func playerTransform(what_to_transform_to : String){
        if(player_state_name != "Human"){
             self.stateMachine?.enter(HumanState.self)
        }
        else if(what_to_transform_to == "Cat"){
            self.stateMachine?.enter(CatState.self)
        }
    }
    func fireBullet(scene : SKScene){
        let bullet = Bullet(imageNamed: "bullet")
       
        bullet.scale(to: CGSize(width: 20, height: 10))
       
        bullet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bullet.size.width, height: bullet.size.height))
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.allowsRotation = false
        bullet.physicsBody?.collisionBitMask = 3
        bullet.physicsBody?.categoryBitMask = 8
        bullet.physicsBody?.contactTestBitMask = 2;
        bullet.name = "bullet"
        bullet.player_ = self
        scene.addChild(bullet)
        var fire = SKAction()
        if (self.xScale > 0){
            fire = SKAction.moveTo(x: self.position.x + self.size.width/2 + 300, duration: 0.2)
            bullet.position = CGPoint(x: self.position.x + self.size.width/2, y: self.position.y)
        }
        else{
            fire = SKAction.moveTo(x: self.position.x - self.size.width/2 - 300, duration: 0.2)
            bullet.position = CGPoint(x: self.position.x - self.size.width/2, y: self.position.y)
        }
        let now_cannot_shoot = SKAction.run {
            self.did_shoot = true
        }
        
        let now_can_shoot = SKAction.run {
            self.did_shoot = false
        }
        let destroy = SKAction.run {
            bullet.removeFromParent()
        }
        let sequence = SKAction.sequence([now_cannot_shoot,fire, now_can_shoot,destroy])
        bullet.run(sequence)
    }
}
