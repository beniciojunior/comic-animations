//
//  MNMActionMotion.swift
//  minimovies
//
//  Created by Benicio Sparapani Junior on 11/09/15.
//  Copyright (c) 2015 beniciosjunior. All rights reserved.
//

import UIKit

class MNMActionMotion: MNMAction {
    
    var horizontalMotion: Float = 0.0
    var verticalMotion: Float = 0.0
    var view: UIView?
    var useDefaultPositioning: Bool = false

    override func runActionWithCompletion(_ completion: @escaping () -> Void) {
        super.runActionWithCompletion(completion)

        if let view = view {
            for motion in view.motionEffects {
                view.removeMotionEffect(motion)
            }
        }
        
        if horizontalMotion > 0 {
            let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
            horizontalMotionEffect.minimumRelativeValue = horizontalMotion * -1
            horizontalMotionEffect.maximumRelativeValue = horizontalMotion
            view?.addMotionEffect(horizontalMotionEffect)
        }
        
        if verticalMotion > 0 {
            let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
            verticalMotionEffect.minimumRelativeValue = verticalMotion * -1
            verticalMotionEffect.maximumRelativeValue = verticalMotion
            view?.addMotionEffect(verticalMotionEffect)
        }
        
        self.status = .Done
        completionBlock(actionCompletion: completion)()
    }
}
