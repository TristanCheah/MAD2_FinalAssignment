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
    static let TRANSFORM : UInt32 = 0x1 << 2//4
    static let BULLET : UInt32 = 0x1 << 3//8
    static let BUTTON : UInt32 = 0x1 << 4
    static let LAVA : UInt32 = 0b101//5
    static let PORTAL : UInt32 = 0b110//6
    static let ENEMYBULLET:UInt32 = 0b111//7
}
class PhysicsDelegate : NSObject, SKPhysicsContactDelegate{
   
    func didBegin(_ contact: SKPhysicsContact) {
        let collision : UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        print(collision)
        
        let string1 : String = (contact.bodyA.node!.name)!
        let string2 : String = (contact.bodyB.node!.name)!
       
        
      
        print(string1 + string2)
        
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
        if collision == ColliderType.ENEMYBULLET | ColliderType.GROUND{
            if let bullet = contact.bodyA.node as? Bullet{
                bullet.DestroySelfEnemy()
                
            }
            else if let bullet = contact.bodyB.node as? Bullet{
                bullet.DestroySelfEnemy()
            }
        }
        if collision == ColliderType.ENEMYBULLET|ColliderType.PLAYER{
           if let player = contact.bodyA.node as? PlayerNode{

               player.is_dead = true;
               
           }
           else if let player = contact.bodyB.node as? PlayerNode{

               player.is_dead = true;
               
           }
       }
        if collision == ColliderType.LAVA|ColliderType.PLAYER{
            if let player = contact.bodyA.node as? PlayerNode{

                player.is_dead = true;
                
            }
            else if let player = contact.bodyB.node as? PlayerNode{

                player.is_dead = true;
                
            }
        }
        if collision == ColliderType.PLAYER | ColliderType.BUTTON{
            if let btn = contact.bodyA.node as? InGameButton{
                btn.is_pressed_ = true;
            }
            
            else if let btn = contact.bodyB.node as? InGameButton{
                btn.is_pressed_ = true;
            }
        }
        if collision == ColliderType.PORTAL|ColliderType.PLAYER{
            if let player = contact.bodyA.node as? PlayerNode{
                if(contact.bodyB.node?.name != "enemybullet"){                player.level_finish = true;
                }
                
            }
            else if let player = contact.bodyB.node as? PlayerNode{

                if(contact.bodyA.node?.name != "enemybullet"){                player.level_finish = true;
                }
                
            }
        }
    }
}
