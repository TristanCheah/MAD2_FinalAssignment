//
//  GameScene.swift
//  MAD2_Assignment
//
//  Created by Tristan Cheah on 16/1/20.
//  Copyright © 2020 Tristan Cheah. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var player_initial_y = CGFloat()
   
    
    private var lastUpdateTime : TimeInterval = 0    
    var joystick : JoystickNode = JoystickNode()
    var player_node : PlayerNode = PlayerNode()
    var shoot_button : Button = Button(imageNamed: "shoot_button")
    var jump_button : Button = Button(imageNamed: "jump_button")
    var transform_button : Button = Button(imageNamed: "button")
    var physics_delegate = PhysicsDelegate()
    
    
    override func sceneDidLoad() {
        self.camera = get_camera()
        self.lastUpdateTime = 0
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        self.backgroundColor = SKColor.green
        
        if let player : PlayerNode = self.childNode(withName: "player") as? PlayerNode{
            player_node = player
            player_node.InstantiatePlayer(player: player_node)
        }
        
        player_initial_y = player_node.position.y+90
        //self.addChild(player_node)
        //HUD
        
        joystick.InstantiateJoystick(scene: self, player_node: player_node, camera: self.camera!)
        
        shoot_button.InstantiateButton(self_button: shoot_button, location:CGPoint(x: 450, y: -200))
        self.camera?.addChild(shoot_button)
        
        jump_button.InstantiateButton(self_button: jump_button, location:CGPoint(x: 390, y: -150))
        self.camera?.addChild(jump_button)
        
        transform_button.InstantiateButton(self_button: transform_button, location: CGPoint(x: 510, y: -150))
        self.camera?.addChild(transform_button)
        //HUD
        self.physicsWorld.contactDelegate = physics_delegate
        
    }
    
    func get_camera()->SKCameraNode{
        
        for child in self.children {
            
            if(child.name == "camera"){
                return child as! SKCameraNode
            }
        }
        return SKCameraNode();
    }
// JOYSTICK SETUP
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player_node.can_jump = true
        for t in touches {
            
            let location = t.location(in: self.camera!)
            
            if(joystick.base.frame.contains(location)){
                joystick.stickActive = true
                player_node.walkingRight = false
                player_node.walkingLeft = false
            }
            else{
                joystick.stickActive = false
            }
            
            if (jump_button.frame.contains(location)){
                player_node.jump = true;
            }
            if(shoot_button.frame.contains(location) && player_node.did_shoot == false){
                //shoot
                if(player_node.player_state_name == "Human"){
                    player_node.fireBullet(scene: self)
                }
            }
            if(transform_button.frame.contains(location)){
                player_node.playerTransform(what_to_transform_to: player_node.player_state_name)
            }
            
        }
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in (touches as Set<UITouch>){
            let location = t.location(in:self.camera!)
            if(joystick.stickActive == true){
                let v = CGVector(dx: location.x - joystick.base.position.x, dy: location.y - joystick.base.position.y)
                
                let angle = atan2(v.dy, v.dx)
                let deg = (angle * CGFloat(180/Double.pi)) + 180
                
                let length:CGFloat = joystick.base.frame.size.height/2
                
                let x_dist:CGFloat = sin(angle - 1.57079633) * length
                let y_dist :CGFloat = cos(angle - 1.57079633) * length //90 ded in radians
                
                
                
                if(joystick.base.frame.contains(location)){
                    joystick.ball.position = location
                }
                else{
                    joystick.ball.position = CGPoint(x:joystick.base.position.x - x_dist, y:joystick.base.position.y + y_dist)
                }
               
                print(deg)
                if (deg < 90 || deg > 315){
                    
                    player_node.walkingLeft = true
                }
                else{
                    player_node.walkingLeft = false
                }
                
                if(deg < 225){
                    
                    player_node.walkingRight = true
                }
                else{
                    player_node.walkingRight = false
                }
                /*if(deg < 315 && deg > 225){
                   //jump
                    player_node.can_jump = true
                    player_node.jump = true
                }
                else{
                    player_node.can_jump = false
                }*/
              
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            if (joystick.stickActive == true){
                let move:SKAction = SKAction.move(to: joystick.base.position, duration: 0.2)
                move.timingMode = .easeOut
                
                joystick.ball.run(move)
                player_node.can_jump = true
                player_node.walkingLeft = false
                player_node.walkingRight = false
        }
    }
    
//JOYSTICK SETUP
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        player_node.stateMachine?.update(deltaTime: dt)
        let cam_pos_y : CGFloat = player_node.position.y + 90
        camera?.position = CGPoint(x: player_node.position.x, y: cam_pos_y)
        
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
