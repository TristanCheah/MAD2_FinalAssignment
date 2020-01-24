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
        player.name = "player"
        
    }
    
   
    
   
   
    func setupStateMachine(){
        let humanState = HumanState(player_node_: self)
        
        stateMachine = GKStateMachine(states: [humanState])
        stateMachine!.enter(HumanState.self)
    }
}
