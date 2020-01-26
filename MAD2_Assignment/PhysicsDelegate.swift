//
//  PhysicsDelegate.swift
//  MAD2_Assignment
//
//  Created by Tristan Cheah on 24/1/20.
//  Copyright © 2020 Tristan Cheah. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
struct ColliderType {
    static let PLAYER : UInt32 = 0x1 << 0
    static let GROUND : UInt32 = 0x1 << 1
}
class PhysicsDelegate : NSObject, SKPhysicsContactDelegate{
   
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision : UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == ColliderType.PLAYER | ColliderType.GROUND{
           // print(contact.bodyA.node!.name as String? ?? "")
          //  print(contact.bodyB.node!.name as String? ?? "")
            if let player = contact.bodyA.node as? PlayerNode{
                player.grounded = true
            }
            else if let player = contact.bodyB.node as? PlayerNode{
                player.grounded = true
            }            
        }
    }
}