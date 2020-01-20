//
//  FrontViewController.swift
//  MAD2_Assignment
//
//  Created by Tristan Cheah on 20/1/20.
//  Copyright © 2020 Tristan Cheah. All rights reserved.
//

import Foundation
import UIKit

class FrontViewController:UIViewController{
    @IBAction func playbtn(_ sender: Any) {
        
    }
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        if let secondViewController = segue.destination as? GameViewController{
            secondViewController.modalPresentationStyle = .fullScreen
        }
        if let secondViewController = segue.destination as? NavigationViewController{
            secondViewController.modalPresentationStyle = .fullScreen
        }
    }
}
