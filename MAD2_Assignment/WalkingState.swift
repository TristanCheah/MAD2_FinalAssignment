//
//  WalkingState.swift
//  MAD2_Assignment
//
//  Created by Tristan Cheah on 24/1/20.
//  Copyright © 2020 Tristan Cheah. All rights reserved.
//

import Foundation
import GameplayKit
class WalkingState : GKState{
    var player_node :PlayerNode;
    init(player_node_:PlayerNode){
        player_node = player_node_
    }
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
       
        return stateClass == JumpingState.self
        
    }
    override func update(deltaTime seconds: TimeInterval) {
        var accelSpeed : CGFloat  = 0.0
        var decelSpeed : CGFloat = 0.0
        
        print(player_node.grounded)
        
        if(player_node.grounded){
            accelSpeed = player_node.groundAccel
            decelSpeed = player_node.groundDecel
        }
        else{
            accelSpeed = player_node.airAccel
            accelSpeed = player_node.airDecel
        }
        if(player_node.walkingLeft == true){
            player_node.speed_ = approach(start: player_node.speed_, end: -5, shift: accelSpeed)
        }
        else if (player_node.walkingRight == true){
            player_node.speed_ = approach(start: player_node.speed_, end: 5, shift: accelSpeed)
        }
        else{
            player_node.speed_ = approach(start: player_node.speed_, end: 0.0, shift: decelSpeed)
        }
        player_node.player.position.x += player_node.speed_;
        /*if (player_node.can_jump == true){
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
