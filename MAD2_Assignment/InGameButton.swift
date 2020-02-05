//
//  InGameButton.swift
//  MAD2_Assignment
//
//  Created by Tristan Cheah on 4/2/20.
//  Copyright © 2020 Tristan Cheah. All rights reserved.
//

import Foundation
import SpriteKit
class InGameButton : SKSpriteNode{
    
    //var player_ : PlayerNode = PlayerNode();
    public var is_pressed_:Bool = false;
    
    func InitializeButton()
    {
        is_pressed_ = false;
    }
}
