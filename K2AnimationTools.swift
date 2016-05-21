//
//  K2HelperTools.swift
//
//  Created by Kailen & Kathryne Engel on 3/2/16.
//  Copyright © 2016 K2. All rights reserved.
//
//  Animation utility functions
//

func addAnimationTo (
    layer: CALayer,
    property: String,
    duration: Double,
    from: Double,
    to: Double,
    withTiming timing: String = kCAMediaTimingFunctionEaseInEaseOut) {
        
        // Implementation
        let animation = CABasicAnimation(keyPath: property)
        animation.duration = duration
        animation.fromValue = from
        animation.toValue = to
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: timing)
        layer.addAnimation(animation, forKey: property)
}