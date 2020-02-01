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
    static let PLAYER : UInt32 = 0x1 << 0 //1
    static let GROUND : UInt32 = 0x1 << 1 //2
    static let TRANSFORM : UInt32 = 0x1 << 2
    static let BULLET : UInt32 = 0x1 << 3
    
}
class PhysicsDelegate : NSObject, SKPhysicsContactDelegate{
   
    func didBegin(_ contact: SKPhysicsContact) {
        let collision : UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        print(collision)
        print(contact.bodyA.node!.name as String? ?? "")
        print(contact.bodyB.node!.name as String? ?? "")
        if collision == ColliderType.PLAYER | ColliderType.GROUND{
            
            if let player = contact.bodyA.node as? PlayerNode{
                player.grounded = true
            }
            else if let player = contact.bodyB.node as? PlayerNode{
                player.grounded = true
            }            
        }
        if collision == ColliderType.BULLET | ColliderType.GROUND{
            if let bullet = contact.bodyA.node as? Bullet{
                bullet.DestroySelf()
                
            }
            else if let bullet = contact.bodyB.node as? Bullet{
                bullet.DestroySelf()
            }
        }
        if collision == ColliderType.BULLET | ColliderType.TRANSFORM{
            if let bullet = contact.bodyA.node as? Bullet{
                bullet.DestroySelf()
                bullet.ChangePlayerState(object_hit: contact.bodyB.node!)
            }
            else if let bullet = contact.bodyB.node as? Bullet{
                bullet.DestroySelf()
                bullet.ChangePlayerState(object_hit: contact.bodyA.node!)
            }
            
        }
    }
}
