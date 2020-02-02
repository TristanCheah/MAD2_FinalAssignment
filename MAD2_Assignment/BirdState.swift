//
//  BirdState.swift
//  MAD2_Assignment
//
//  Created by Tristan Cheah on 1/2/20.
//  Copyright © 2020 Tristan Cheah. All rights reserved.
//

import Foundation
import GameplayKit
class BirdState : GKState
{
    var player_node :PlayerNode;
    init(player_node_:PlayerNode){
        player_node = player_node_
    }
    func approach(start:CGFloat, end:CGFloat, shift:CGFloat)->CGFloat{
        if (start < end){
            return min(start + shift, end)
        }
        else{
            return max(start - shift, end)
        }
    }
    override func update(deltaTime seconds: TimeInterval) {
        player_node.player_state_name = "Bird"
        
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
        player_node.position.x += player_node.speed_;
    }
}
