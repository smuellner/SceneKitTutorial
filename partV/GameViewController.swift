//
//  GameViewController.swift
//
//  Part 5 of the SceneKit Tutorial Series 'From Zero to Hero' at:
//  https://rogerboesch.github.io/
//
//  Created by Roger Boesch on 12/07/16.
//  Copyright © 2016 Roger Boesch. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class GameViewController: UIViewController, SCNSceneRendererDelegate {
    private var _sceneView: SCNView!
    private var _level: GameLevel!
    private var _hud: HUD!

    // New in Part 5: Use CoreMotion to fly the plane
    private var _motionManager = MotionManager()       // Current attitude

    // -------------------------------------------------------------------------
    // MARK: - Properties

    var sceneView: SCNView {
        return _sceneView
    }

    // -------------------------------------------------------------------------

    var hud: HUD {
        return _hud
    }

    // -------------------------------------------------------------------------
    // MARK: - Render delegate (New in Part 4)
    
    func renderer(_ renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: TimeInterval) {
        guard _level != nil else { return }

        _level.update(atTime: time)
        renderer.loops = true
    }

    // -------------------------------------------------------------------------
    // MARK: - Gesture recognoizers
    
    @objc private func handleTap(_ gestureRecognize: UITapGestureRecognizer) {
        // New in Part 4: A tap is used to restart the level (see tutorial)
        if _level.state == .loose || _level.state == .win {
            _motionManager.stop()
            _level.stop()
            _level = nil
            
            DispatchQueue.main.async {
                // Create things in main thread
                
                let level = GameLevel()
                level.create()
                
                level.hud = self.hud
                self.hud.reset()
                
                self.sceneView.scene = level
                self._level = level

                self.hud.message("READY?", information: "- Touch screen to start -")
            }
        }
        // New in Part 5: A tap is used to start the level (see tutorial)
        else if _level.state == .ready {
            _motionManager.start()
            _level.start()
        }
    }

    // -------------------------------------------------------------------------

    @objc private func handleSwipe(_ gestureRecognize: UISwipeGestureRecognizer) {
        if _level.state != .play {
            return
        }
        
        if (gestureRecognize.direction == .left) {
            _level!.swipeLeft()
        }
        else if (gestureRecognize.direction == .right) {
            _level!.swipeRight()
        }
        else if (gestureRecognize.direction == .down) {
            _level!.swipeDown()
        }
        else if (gestureRecognize.direction == .up) {
            _level!.swipeUp()
        }
    }
    

    // -------------------------------------------------------------------------
    // MARK: - ViewController life cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Part 3: HUD is created and assigned to view and game level
        _hud = HUD(size: self.view.bounds.size)
        _level.hud = _hud
        _sceneView.overlaySKScene = _hud.scene
        
        self.hud.message("READY?", information: "- Touch screen to start -")
    }

    // -------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _level = GameLevel()
        _level.create()
        
        _sceneView = SCNView()
        _sceneView.scene = _level
        _sceneView.allowsCameraControl = false
        _sceneView.showsStatistics = false
        _sceneView.backgroundColor = UIColor.black
        _sceneView.delegate = self
        
        _motionManager.delegate = self

        self.view = _sceneView

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        _sceneView!.addGestureRecognizer(tapGesture)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeftGesture.direction = .left
        _sceneView!.addGestureRecognizer(swipeLeftGesture)

        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRightGesture.direction = .right
        _sceneView!.addGestureRecognizer(swipeRightGesture)

        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDownGesture.direction = .down
        _sceneView!.addGestureRecognizer(swipeDownGesture)

        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUpGesture.direction = .up
        _sceneView!.addGestureRecognizer(swipeUpGesture)
    }

    // -------------------------------------------------------------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // -------------------------------------------------------------------------

}

extension GameViewController: MotionManagerDelegate {
    func motionMoveUp() {
        _level.motionMoveUp()
    }
    
    func motionMoveDown() {
        _level.motionMoveDown()
    }
    
    func motionStopMovingUpDown() {
        _level.motionStopMovingUpDown()
    }
    
    func motionMoveLeft() {
        _level.motionMoveLeft()
    }
    
    func motionMoveRight() {
        _level.motionMoveRight()
    }
    
    func motionStopMovingLeftRight() {
        _level.motionStopMovingLeftRight()
    }
}
