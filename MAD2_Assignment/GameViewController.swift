//
//  GameViewController.swift
//  MAD2_Assignment
//
//  Created by Tristan Cheah on 16/1/20.
//  Copyright © 2020 Tristan Cheah. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = SKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            scene.scaleMode = .aspectFill    
                // Present the scene
            if let view = self.view as! SKView? {
                view.presentScene(scene)
                
                view.ignoresSiblingOrder = true
                
                view.showsFPS = true
                view.showsNodeCount = true
            }
            
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
