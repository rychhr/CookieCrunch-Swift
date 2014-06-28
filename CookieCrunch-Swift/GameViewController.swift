//
//  GameViewController.swift
//  CookieCrunch-Swift
//
//  Created by Ryoichi Hara on 2014/06/28.
//  Copyright (c) 2014 Ryoichi Hara. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var scene: GameScene!
    var level: Level!

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the view
        let skView = view as SKView
        skView.multipleTouchEnabled = false

        // Create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill

        level = Level()
        scene.level = level

        // Present the scene
        skView.presentScene(scene)

        beginGame()
    }

    func beginGame() {
        shuffle()
    }

    func shuffle() {
        let newCookies = level.shuffle()
        scene.addSpritesForCookies(newCookies)
    }
}
