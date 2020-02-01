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
    
}
