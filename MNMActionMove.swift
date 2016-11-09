//
//  MNMActionMove.swift
//  minimovies
//
//  Created by Benicio Sparapani Junior on 09/09/15.
//  Copyright (c) 2015 beniciosjunior. All rights reserved.
//

import UIKit

class MNMActionMove: MNMAction {
    
    var postion: CGPoint = CGPoint(x: 0, y: 0)
    
    override func runActionWithCompletion(_ completion: @escaping () -> Void) {
        super.runActionWithCompletion(completion)
        
        if duration > 0.0 {
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({ [weak self] () -> Void in
                self?.status = .Done
                self?.completionBlock(actionCompletion: completion)()
            })

            if let layer = layer {
            
                let animation = CABasicAnimation(keyPath: "position")
                animation.fromValue = layer.value(forKey: "position")
                animation.toValue = NSValue(cgPoint: MNMActionMove.centeredPosition(position: postion, layer: layer))
                animation.duration = duration

                if let timingType = timingType {
                    animation.timingFunction = CAMediaTimingFunction(name: timingType)
                }


                layer.position = MNMActionMove.centeredPosition(position: postion, layer: layer)
                layer.add(animation, forKey: "position")
            }
            
            CATransaction.commit()
            
        } else {

            if let layer = layer {
                layer.position = MNMActionMove.centeredPosition(position: postion, layer: layer)
            }

            self.status = .Done
            completionBlock(actionCompletion: completion)()
        }
    }
    
    class func centeredPosition(position: CGPoint, layer: CALayer) -> CGPoint {
        return CGPoint(x: position.x + layer.frame.size.width/2, y: position.y + layer.frame.size.height/2)
    }
}
