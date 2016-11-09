//
//  MNMActionAnimate.swift
//  minimovies
//
//  Created by Benicio Sparapani Junior on 09/09/15.
//  Copyright (c) 2015 beniciosjunior. All rights reserved.
//

import UIKit

class MNMActionAnimate: MNMAction {
    
    var images: [UIImage] = []
    var autoreverses: Bool = false
    var repeatForever: Bool =  false
    var repeatCount: Float = 0.0
    
    override func accelerate() {
        velocity = .Fast
    }
    
    override func runActionWithCompletion(_ completion: @escaping () -> Void) {
        super.runActionWithCompletion(completion)
        
        if duration > 0.0 {
            
            let animationSequence = CAKeyframeAnimation(keyPath: "contents")
            animationSequence.calculationMode = kCAAnimationLinear
            animationSequence.autoreverses = autoreverses
            animationSequence.duration = duration

            var animationSequenceArray = [] as [CGImage]
            
            for image in images {
                if let cgImage = image.cgImage {
                    animationSequenceArray.append(cgImage)
                }
            }
            
            animationSequence.values = animationSequenceArray
            
            if repeatForever {
                animationSequence.repeatCount = Float.infinity
            } else {
                animationSequence.repeatCount = repeatCount
            }
            
            layer?.add(animationSequence, forKey: "contents")
            
            let image = images.last
            layer?.contents = image?.cgImage
            
        } else if images.count > 0 {
            let image = images.first
            layer?.contents = image?.cgImage
            self.status = .Done
            
        } else {
            layer?.removeAnimation(forKey: "contents")
            self.status = .Done
        }
        
        completionBlock(actionCompletion: completion)()
    }
}
