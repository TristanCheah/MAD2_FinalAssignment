//
//  EnemyTurret.swift
//  MAD2_Assignment
//
//  Created by Tristan Cheah on 4/2/20.
//  Copyright © 2020 Tristan Cheah. All rights reserved.
//

import Foundation
import SpriteKit
class EnemyTurret : SKSpriteNode{
    
    var did_shoot: Bool = false;
    
    func fireBullet(scene : SKScene){
        let bullet = Bullet(imageNamed: "bullet")
       
        bullet.scale(to: CGSize(width: 20, height: 10))
       
        bullet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bullet.size.width, height: bullet.size.height))
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.allowsRotation = false
        bullet.physicsBody?.collisionBitMask = 3
        bullet.physicsBody?.categoryBitMask = 7
        bullet.physicsBody?.contactTestBitMask = 2;
        bullet.name = "bullet"
        
        scene.addChild(bullet)
        let delay = SKAction.wait(forDuration: 1)
        let fire = SKAction.moveTo(x: self.position.x + self.size.width/2 + 5000, duration: 1)
        bullet.position = CGPoint(x: self.position.x + self.size.width/2, y: self.position.y)
        /*if (self.xScale > 0){
            fire = SKAction.moveTo(x: self.position.x + self.size.width/2 + 600, duration: 0.2)
            bullet.position = CGPoint(x: self.position.x + self.size.width/2, y: self.position.y)
        }
        else{
            fire = SKAction.moveTo(x: self.position.x - self.size.width/2 - 600, duration: 0.2)
            bullet.position = CGPoint(x: self.position.x - self.size.width/2, y: self.position.y)
        }
        let now_cannot_shoot = SKAction.run {
            self.did_shoot = true
        }
        
        let now_can_shoot = SKAction.run {
            self.did_shoot = false
        }*/
        let destroy = SKAction.run {
            bullet.removeFromParent()
        }
        let sequence = SKAction.sequence([delay, fire, destroy])
        bullet.run(sequence)
    }

    
}
