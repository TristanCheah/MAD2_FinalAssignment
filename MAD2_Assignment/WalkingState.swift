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
        print("hello")
        if(player_node.walkingLeft == true){
            player_node.walkLeft()
        }
        else if (player_node.walkingRight == true){
            player_node.walkRight()
        }
        
        if (player_node.can_jump == true){
            self.stateMachine?.enter(JumpingState.self)
        }
        
    }
}
