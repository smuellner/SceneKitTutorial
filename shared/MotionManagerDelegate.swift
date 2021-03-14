//
//  MotionManagerDelegate.swift
//  tutorialTV
//
//  Created by smuellner on 14.03.21.
//

protocol MotionManagerDelegate {
    func motionMoveUp()
    func motionMoveDown()
    func motionStopMovingUpDown()
    func motionMoveLeft()
    func motionMoveRight()
    func motionStopMovingLeftRight()
}
