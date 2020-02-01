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
    override func update(deltaTime seconds: TimeInterval) {
        player_node.player_state_name = "Bird"
    }
}
