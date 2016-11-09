//
//  MNMActionFade.swift
//  minimovies
//
//  Created by Benicio Sparapani Junior on 09/09/15.
//  Copyright (c) 2015 beniciosjunior. All rights reserved.
//

import UIKit

class MNMActionFade: MNMAction {

    var fade: Float = 0.0
    
    override func runActionWithCompletion(_ completion: @escaping () -> Void) {
        super.runActionWithCompletion(completion)
        
        if duration > 0.0 {
            CATransaction.begin()
            CATransaction.setCompletionBlock({ [weak self] () -> Void in
                self?.status = .Done
                self?.completionBlock(actionCompletion: completion)()
            })
            
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.duration = duration
            animation.fromValue = layer?.opacity
            animation.toValue = fade
            
            if let timingType = timingType {
                animation.timingFunction = CAMediaTimingFunction(name: timingType)
            }
            
            layer?.opacity = fade
            layer?.add(animation, forKey: "opacity")
            
            CATransaction.commit()
            
        } else {
            layer?.opacity = fade
            self.status = .Done
            completionBlock(actionCompletion: completion)()
        }
    }
}
