//
//  MotionManager+tvos.swift
//  tutorialTV
//
//  Created by smuellner on 14.03.21.
//

import Foundation
import GameController

class MotionManager {
    // private var _motionManager = CMMotionManager()
    // private var _startAttitude: CMAttitude?             // Start attitude
    // private var _currentAttitude: CMAttitude?
    public var delegate: MotionManagerDelegate?
    
    // -------------------------------------------------------------------------

    public func start() {
        /*
        if (GCController.controllers().count == 0
                && _motionManager.isAccelerometerAvailable) {
            _startAttitude = _currentAttitude
            _motionManager.accelerometerUpdateInterval = 1/60.0
            _motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: {(data, error) in
                self.motionDidChange(data: data!)
            })
        }
 */
    }
    
    public func stop() {
        /*
        if (GCController.controllers().count == 0 && _motionManager.isAccelerometerAvailable) {
            _motionManager.stopDeviceMotionUpdates()
        }
 */
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Motion handling
    /*
    private func motionDidChange(data: CMDeviceMotion) {
        _currentAttitude = data.attitude
        
        // guard _level != nil, _level?.state == .play else { return }
        guard let delegate = delegate else { return }

        // Up/Down
        let diff1 = _startAttitude!.roll - _currentAttitude!.roll
        
        if (diff1 >= Game.Motion.threshold) {
            delegate.motionMoveUp()
        }
        else if (diff1 <= -Game.Motion.threshold) {
            delegate.motionMoveDown()
        }
        else {
            delegate.motionStopMovingUpDown()
        }
        
        let diff2 = _startAttitude!.pitch - _currentAttitude!.pitch
        
        if (diff2 >= Game.Motion.threshold) {
            delegate.motionMoveLeft()
        }
        else if (diff2 <= -Game.Motion.threshold) {
            delegate.motionMoveRight()
        }
        else {
            delegate.motionStopMovingLeftRight()
        }
    }
 */
}
