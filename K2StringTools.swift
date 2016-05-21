//
//  K2StringTools.swift
//
//  Created by Kailen & Kathryne Engel on 3/2/16.
//  Copyright © 2016 K2. All rights reserved.
//
//  String & Text utility functions
//

import UIKit

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