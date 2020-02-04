//
//  Button.swift
//  MAD2_Assignment
//
//  Created by Tristan Cheah on 26/1/20.
//  Copyright © 2020 Tristan Cheah. All rights reserved.
//

import Foundation
import SpriteKit
class Button : SKSpriteNode{
    //var button_held : Bool = false
    func InstantiateButton(self_button : Button, location : CGPoint){
        self_button.zPosition = 2;
        self_button.position = location
        self_button.scale(to: CGSize(width: 60, height: 60))
    }
}
