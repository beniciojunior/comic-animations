//
//  MNMActionRotation.swift
//  minimovies
//
//  Created by Benicio Sparapani Junior on 10/09/15.
//  Copyright (c) 2015 beniciosjunior. All rights reserved.
//

import UIKit

class MNMActionRotation: MNMAction {
 
    var repeatForever: Bool = false
    var repeatCount: Float = 0.0
    var rotationValue: Double = 0.0
    
    override func accelerate() {
        if !repeatForever {

            if let layer = layer {
                layer.speed = 2.0
                layer.timeOffset = layer.convertTime(CACurrentMediaTime(), from: nil) - layer.timeOffset as CFTimeInterval
                layer.beginTime = CACurrentMediaTime();
            }
        }
    }
    
    override func runActionWithCompletion(_ completion: @escaping () -> Void) {
        super.runActionWithCompletion(completion)
        
        if duration > 0.0 {
            
            if !repeatForever {
                CATransaction.begin()
                CATransaction.setCompletionBlock({ [weak self] () -> Void in
                    self?.status = .Done
                    self?.completionBlock(actionCompletion: completion)()
                })
            }
            
            let animation = CABasicAnimation(keyPath: "transform.rotation.z")
            animation.fromValue = 0.0 * M_PI
            animation.toValue = rotationValue / 180.0 * M_PI
            animation.duration = duration
            animation.isCumulative = true
            
            if repeatForever {
                animation.repeatCount = Float.infinity
            } else {
                animation.repeatCount = repeatCount
            }
            
            animation.isRemovedOnCompletion = false
            animation.fillMode = kCAFillModeForwards
            
            layer?.add(animation, forKey: "transform.rotation.z")
            
            if repeatForever {
                completionBlock(actionCompletion: completion)()
            } else {
                CATransaction.commit()
            }
            
        } else {
            layer?.removeAnimation(forKey: "transform.rotation.z")
            self.status = .Done
            completionBlock(actionCompletion: completion)()
        }
    }
}
