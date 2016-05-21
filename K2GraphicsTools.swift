//
//  K2GraphicsTools.swift
//
//  Created by Kailen & Kathryne Engel on 3/2/16.
//  Copyright © 2016 K2. All rights reserved.
//
//  Graphics utility functions
//

import UIKit

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