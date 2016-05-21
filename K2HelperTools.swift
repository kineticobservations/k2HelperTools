//
//  K2HelperTools.swift
//
//  Created by Kailen & Kathryne Engel on 3/2/16.
//  Copyright © 2016 K2. All rights reserved.
//

import UIKit

////////////////////////////////
// MARK: String and Text
////////////////////////////////
extension String {
    
    func dropFirstWord () -> String {
        var index = 0
        for i in self.characters {
            if i == " " {
                index += 1
                break
            }
            index += 1
        }
        return String(self.characters.dropFirst(index))
    }
    
    func dropLastWord () -> String {
        var str = String(self.characters.reverse())
        str = str.dropFirstWord()
        return String(str.characters.reverse())
    }
}

///////////////////////////////////////
// MARK: Alert & Notification Functions
///////////////////////////////////////
func makeAlertFor (
    forVC: UIViewController,
    title: String,
    message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let cancel = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
        alert.addAction(cancel)
        forVC.presentViewController(alert, animated: true, completion: nil)
}

func makeAlertWithActionsFor (
    forVC: UIViewController,
    title: String,
    message: String,
    addButtons: (title: String, block: (UIAlertAction->Void))...,
    withCancel: Bool = true) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        for button in addButtons {
            let action = UIAlertAction(title: button.title, style: .Default, handler: button.block)
            alert.addAction(action)
        }
        
        if withCancel {
            let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alert.addAction(cancel)
        }
        
        forVC.presentViewController(alert, animated: true, completion: nil)
}

////////////////////////////////
// MARK: Graphics
////////////////////////////////
func addSimpleGradientToLayer (
    layer: CALayer,
    startColor: UIColor,
    endColor: UIColor,
    atIndex index: UInt32 = 0) {
        
        let gradientColors: [CGColor] = [startColor.CGColor, endColor.CGColor]
        let gradient = CAGradientLayer()
        
        gradient.colors = gradientColors
        gradient.frame = layer.bounds
        
        layer.insertSublayer(gradient, atIndex: index)
}

////////////////////////////////
// MARK: Animation
////////////////////////////////
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

////////////////////////////////
// MARK: Grand Central & Timing
////////////////////////////////

// delay(3) { ... }
func delay (delay: Double, block: ()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), block)
}