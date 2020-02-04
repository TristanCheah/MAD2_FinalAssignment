//
//  JoystickNode.swift
//  MAD2_Assignment
//
//  Created by Tristan Cheah on 24/1/20.
//  Copyright © 2020 Tristan Cheah. All rights reserved.
//

import Foundation
import SpriteKit
class JoystickNode : SKSpriteNode{
    let ball = SKSpriteNode(imageNamed: "joystick_ball")
    let base = SKSpriteNode(imageNamed: "joystick_base")
    var player = PlayerNode()
    
    
    func InstantiateJoystick(scene : SKScene, player_node : PlayerNode, camera: SKCameraNode){
        ball.anchorPoint = CGPoint(x:0.5,y:0.5)
        base.anchorPoint = CGPoint(x:0.5,y:0.5)
        base.position = CGPoint(x: -300, y: -200)
        base.scale(to: CGSize(width: 150, height: 150))
       
        
        ball.position = base.position
        ball.scale(to: CGSize(width: 150, height: 150))
       
        base.alpha = 0.4
        ball.alpha = 0.4
        base.zPosition = 1;
        ball.zPosition = 1;
        
        camera.addChild(base)
        camera.addChild(ball)
        player = player_node
    }
    
    var stickActive : Bool = false
    
    
    
    
    
}
