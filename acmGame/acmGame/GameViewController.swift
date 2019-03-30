//
//  GameViewController.swift
//  acmGame
//
//  Created by Alex  Cowley on 1/29/19.
//  Copyright © 2019 Alex  Cowley. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene =
            GameScene(size:CGSize(width: 2048, height: 1536))
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        //skView.showsPhysics = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
