//
//  WalkingState.swift
//  MAD2_Assignment
//
//  Created by Tristan Cheah on 24/1/20.
//  Copyright © 2020 Tristan Cheah. All rights reserved.
//

import Foundation
import GameplayKit
class HumanState : GKState{
    var player_node :PlayerNode;
    init(player_node_:PlayerNode){
        player_node = player_node_
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        var accelSpeed : CGFloat  = 0.0
        var decelSpeed : CGFloat = 0.0
        
       
        if(player_node.grounded){
            accelSpeed = player_node.groundAccel
            decelSpeed = player_node.groundDecel
        }
        else{
            accelSpeed = player_node.airAccel
            decelSpeed = player_node.airDecel
        }
        if(player_node.walkingLeft == true){
            if(player_node.xScale > 0){
                player_node.xScale = -player_node.xScale
            }
            player_node.speed_ = approach(start: player_node.speed_, end: -5, shift: accelSpeed)
        }
        else if (player_node.walkingRight == true){
            if(player_node.xScale < 0){
                player_node.xScale = -player_node.xScale
            }
           
            player_node.speed_ = approach(start: player_node.speed_, end: 5, shift: accelSpeed)
        }
        else{
            player_node.speed_ = approach(start: player_node.speed_, end: 0.0, shift: decelSpeed)
        }
       
        if(player_node.grounded){
            if !player_node.landed{
                player_node.physicsBody?.applyImpulse(CGVector(dx: (player_node.physicsBody?.velocity.dx)!, dy: 0.0))
                player_node.landed = true
            }
            if player_node.jump{
                player_node.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: player_node.max_jump))
                player_node.grounded = false
            }
        }
        if (!player_node.grounded){
            if ((player_node.physicsBody?.velocity.dy)! < CGFloat(0.0)){
                player_node.jump = false
            }
            if ((player_node.physicsBody?.velocity.dy)! > CGFloat(0.0) && !player_node.jump){
                player_node.physicsBody?.velocity.dy *= 0.5
                
            }
            player_node.landed = false
        }
        
        
        player_node.position.x += player_node.speed_;
       /* if (player_node.can_jump == true){
            self.stateMachine?.enter(JumpingState.self)
        }*/
        
    }
    
    func approach(start:CGFloat, end:CGFloat, shift:CGFloat)->CGFloat{
        if (start < end){
            return min(start + shift, end)
        }
        else{
            return max(start - shift, end)
        }
    }
}
