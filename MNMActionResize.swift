//
//  MNMActionResize.swift
//  minimovies
//
//  Created by Benicio Sparapani Junior on 09/09/15.
//  Copyright (c) 2015 beniciosjunior. All rights reserved.
//

import UIKit

class MNMActionResize: MNMAction {
    
    var size: CGSize = CGSize(width: 0, height: 0)
    
    override func runActionWithCompletion(_ completion: @escaping () -> Void) {
        super.runActionWithCompletion(completion)
        
        if duration > 0.0 {
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({ [weak self] () -> Void in
                self?.status = .Done
                self?.completionBlock(actionCompletion: completion)()
            })

            let oldBounds = layer?.bounds
            var newBounds = oldBounds
            newBounds?.size = size

            let animation = CABasicAnimation(keyPath: "bounds")

            if let oldBounds = oldBounds, let newBounds = newBounds {
                animation.fromValue = NSValue(cgRect: oldBounds)
                animation.toValue = NSValue(cgRect: newBounds)

                animation.duration = duration

                if let timingType = timingType {
                    animation.timingFunction = CAMediaTimingFunction(name: timingType)
                }

                layer?.bounds = newBounds
                layer?.add(animation, forKey: "bounds")
            }

            CATransaction.commit()
            
        } else {
            var newBounds = layer?.bounds
            newBounds?.size = size

            if let newBounds = newBounds {
                layer?.bounds = newBounds
                self.status = .Done
            }

            completionBlock(actionCompletion: completion)()
        }
    }
}
