//
//  SKShapeNode+Extensions.swift
//  Reef Battle
//
//  Created by Kathryne Engel on 6/21/17.
//  Copyright © 2017 Lawson & Dawson LLC. All rights reserved.
//

import SpriteKit

extension SKShapeNode {
    func generateTexture() -> SKTexture? {
        
        guard let path = self.path else { return nil }
        
        let frameRect = CGRect(x: 0, y: 0,
                               width: path.boundingBox.width + lineWidth,
                               height: path.boundingBox.height + lineWidth)
        
        var transform = CGAffineTransform.init(translationX: lineWidth * 0.5,
                                               y: lineWidth * 0.5)
        guard let newPath = path.copy(using: &transform) else { return nil }
        
        // context parameters: (size:opaque:scale)
        UIGraphicsBeginImageContextWithOptions(frameRect.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.clip(to: frameRect)
        context.setFillColor(fillColor.cgColor)
        context.setStrokeColor(strokeColor.cgColor)
        context.setLineWidth(lineWidth)
        context.addPath(newPath)
        
        context.drawPath(using: .fillStroke)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        
        return SKTexture(image: image)
    }
    
    func generateSprite() -> SKSpriteNode? {
        return SKSpriteNode(texture: generateTexture())
    }
}
