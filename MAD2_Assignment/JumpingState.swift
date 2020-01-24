//
//  JumpingState.swift
//  MAD2_Assignment
//
//  Created by Tristan Cheah on 24/1/20.
//  Copyright © 2020 Tristan Cheah. All rights reserved.
//

import Foundation
import GameplayKit
class JumpingState : GKState{
    var player_node :PlayerNode;
    init(player_node_:PlayerNode){
        player_node = player_node_
    }
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
       
        return stateClass == WalkingState.self
    }
    override func update(deltaTime seconds: TimeInterval) {
        
        if(player_node.landed && player_node.jump == false){
            self.stateMachine?.enter(WalkingState.self)
        }
    }
    
}
