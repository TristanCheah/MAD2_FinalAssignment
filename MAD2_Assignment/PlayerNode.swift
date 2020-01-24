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
class PlayerNode{
    let player = SKSpriteNode(imageNamed: "player")
    var current_Scene :SKScene = SKScene()
    var stateMachine :GKStateMachine?
    var stickActive : Bool = false
    var lastDirection: Int = 0 //0 is null, 1 is left, 2 is right
    var walkingLeft : Bool = false
    var walkingRight : Bool = false
   
    var can_jump : Bool = true
    
    func InstantiatePlayer(scene : SKScene){
        player.position = CGPoint(x: 100, y: -200);
        setupStateMachine()
        player.scale(to: CGSize(width: 100, height: 100));
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height))
        player.physicsBody?.restitution = 0.0 //stops player from bouncing
        player.name = "player"
        current_Scene = scene
        scene.addChild(player)
        
    }
    
   
    
    func jump(){
        // move up 20
        let jumpUpAction = SKAction.moveBy(x: 0, y: 20, duration: 1)
        
        let finish = SKAction.run {
            self.can_jump = false
        }
        // move down 20
        let jumpSequence = SKAction.sequence([jumpUpAction, finish])
        player.run(jumpSequence)
    }
    func walkLeft(){
        player.position.x -= 4;

    }
    func walkRight(){
        player.position.x += 4;

    }
    func setupStateMachine(){
        let walkingState = WalkingState(player_node_: self)
        let jumpingState = JumpingState(player_node_: self)
        stateMachine = GKStateMachine(states: [walkingState, jumpingState])
        stateMachine!.enter(WalkingState.self)
    }
}
