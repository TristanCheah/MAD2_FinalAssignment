//
//  Bullet.swift
//  MAD2_Assignment
//
//  Created by Tristan Cheah on 1/2/20.
//  Copyright © 2020 Tristan Cheah. All rights reserved.
//

import Foundation
import SpriteKit
class Bullet : SKSpriteNode{
    var player_ : PlayerNode = PlayerNode();
    func DestroySelf(){
        let now_can_shoot = SKAction.run {
            self.player_.did_shoot = false
        }
        let destroy = SKAction.run {
            self.removeFromParent()
        }
        let sequence = SKAction.sequence([now_can_shoot,destroy])
        self.run(sequence)
    }
    func ChangePlayerState(object_hit:SKNode){
        print(object_hit.name!)
        print(player_.player_state_name)
        if(object_hit.name! == player_.player_state_name){
            player_.stateMachine?.enter(HumanState.self)
            print("Back to Human")
            //player_.stateMachine?.enter(HumanState.self)
        }
        else if(object_hit.name == "Bird"){
            player_.stateMachine?.enter(BirdState.self)
            print("Now Bird")
        }
    }
    
}
