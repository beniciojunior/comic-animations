//
//  MNMAction.swift
//  minimovies
//
//  Created by Benicio Sparapani Junior on 09/09/15.
//  Copyright (c) 2015 beniciosjunior. All rights reserved.
//

import UIKit

enum ActionStatus : String {
    case Ready, Animating, Paused, Done
}

enum VelocityStatus : String {
    case Fast, Normal
}

enum ReadingType : String {
    case Neutral = "neutral", Narration = "narration", Reading = "reading"
}


class MNMAction: NSObject {
    
    /* A convenience method for creating common timing functions. The
    * currently supported names are `linear', `easeIn', `easeOut' and
    * `easeInEaseOut' and `default' (the curve used by implicit animations
    * created by Core Animation). */
 
    var identifier: String = ""
    var layer: CALayer?
    var layerString: String?
    var stepNumber: NSInteger = 0
    var duration: TimeInterval = 0.0
    var linkedAction: String?
    var timingType: String?
    var readingType = ReadingType.Neutral
    var status = ActionStatus.Ready
    var velocity = VelocityStatus.Normal
    var cancelled = false
    
    func completionBlock(actionCompletion: @escaping () -> Void) -> (() -> Void) {
        
        func completion() -> Void {
            layer?.speed = 1.0
            actionCompletion()
        }
        
        return completion
    }
    
    func runActionWithCompletion(_ completion: @escaping () -> Void) {
        self.status = .Animating
    }
    
    func pause() {
        if let layer = layer {
            let pausedTime = (layer.convertTime(CACurrentMediaTime(), from: nil)) as CFTimeInterval
            layer.speed = 0.0
            layer.timeOffset = pausedTime
            status = .Paused
        }
    }
    
    func resume() {
        if let layer = layer {
            let pausedTime = layer.timeOffset
            layer.speed = 1.0
            layer.beginTime = 0.0
            let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime as CFTimeInterval
            layer.beginTime = timeSincePause
            status = .Animating
        }
    }
    
    func accelerate() {
        self.velocity = .Fast
        layer?.speed = 2.0
    }
}
