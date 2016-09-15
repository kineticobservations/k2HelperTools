//
//  K2StringExtensions.swift
//  
//
//  Created by Kailen Engel on 9/12/16.
//
//

import Foundation

//////////////////////////////////////////////////////////////////////////////////////////
// K2 String Extensions
//
// aString.length: string length
// aString.contains: is target in self
// aString.replace: put new string into target
// aString[Int]: individual character returned as string and set with replacement
// aString.[4..(.|<)8]: substring from range and set with replacement
// aString.substring: grabs subsection of string
// aString.index(of: return index of first instance of string
// aString.index(of, startingAt: return index of first instance after the startingAt index
// aString.last(indexOf: return index of last instance of string
// aString.isMatch: true is regex pattern is in string
// aString.getMatches: returns array of strings that match the regex
// aString.pluralize: returns an english language pluralization of the end of the string
// aString.dropFirstWord: returns a string with first word dropped
// aString.dropLastWord: returns a string with the last word dropped
// aString.containsOnly: return a bool for whether the string is only letters
///////////////////////////////////////////////////////////////////////////////////////////

extension String {
    var length: Int {
        get {
            return self.characters.count
        }
    }
    
    func contains(s: String) -> Bool {
        return self.range(of: s) != nil ? true : false
    }
    
    func replace(target: String, with string: String) -> String {
        return self.replacingOccurrences(of: target, with: string, options: String.CompareOptions.literal, range: nil)
    }
    
    subscript(i: Int) -> String {
        get {
            let index = self.index(self.startIndex, offsetBy: i)
            return String(self[index])
        }
        
        set(s) {
            let range = self.index(self.startIndex, offsetBy: i)..<self.index(self.startIndex, offsetBy: i+1)
            self.replaceSubrange(range, with: s)
        }
    }
    
    subscript(range: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
            let endIndex   = self.index(self.startIndex, offsetBy: range.upperBound)
            return self[startIndex..<endIndex]
        }
        
        set(s) {
            let stringRange = self.index(self.startIndex, offsetBy: range.lowerBound)..<self.index(self.startIndex, offsetBy: range.upperBound)
            self.replaceSubrange(stringRange, with: s)
        }
    }
    
    subscript(range: ClosedRange<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
            let endIndex   = self.index(self.startIndex, offsetBy: range.upperBound)
            return self[startIndex...endIndex]
        }
        
        set(s) {
            let stringRange = self.index(self.startIndex, offsetBy: range.lowerBound)...self.index(self.startIndex, offsetBy: range.upperBound)
            self.replaceSubrange(stringRange, with: s)
        }
    }
    
    func substring(start from: Int, length: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: from)
        let end   = self.index(self.startIndex, offsetBy: from+length)
        return self.substring(with: start..<end)
    }
    
    func index(of target: String) -> Int? {
        let range = self.range(of: target)
        if let range = range {
            return self.distance(from: self.startIndex, to: range.lowerBound)
        } else {
            return nil
        }
    }
    
    func index(of target: String, startingAt index: Int) -> Int? {
        let startRange = self.index(self.startIndex, offsetBy: index)
        let range = self.range(of: target, options: String.CompareOptions.literal, range: startRange..<self.endIndex)
        
        if let range = range {
            return self.distance(from: self.startIndex, to: range.lowerBound)
        } else {
            return nil
        }
    }
    
    func last(indexOf target: String) -> Int? {
        var index: Int? = nil
        var stepIndex   = self.index(of: target)
        
        while stepIndex != nil {
            index = stepIndex
            
            if (stepIndex! + target.length) < self.length {
                stepIndex = self.index(of: target, startingAt: stepIndex! + target.length)
            } else {
                stepIndex = nil
            }
        }
        return index
    }
    
    func isMatch(to expression: String, options: NSRegularExpression.Options) -> Bool {
        do {
            let regex  = try NSRegularExpression(pattern: expression, options: options)
            let result = regex.firstMatch(in: self,
                                          options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                          range: NSRange(location: 0, length: self.length))
            
            if result != nil { return true }
        } catch {
            return false
        }
        return false
    }
    
    func getMatches(to expression: String, options: NSRegularExpression.Options) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: expression, options: options)
            let nsString = self as NSString
            let results = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.length))
            return results.map { nsString.substring(with: $0.range) }
        } catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    private var vowels: [String]
        {
        get
        {
            return ["a", "e", "i", "o", "u"]
        }
    }
    
    private var consonants: [String]
        {
        get
        {
            return ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z"]
        }
    }
    
    func pluralize() -> String {
        let lastChar            = self.substring(start: self.length - 1, length: 1)
        let secondToLastChar    = self.substring(start: self.length - 2, length: 1)
        var prefix = "", suffix = ""
        
        if lastChar.lowercased() == "y" && vowels.filter({ x in x == secondToLastChar }).count == 1 {
            prefix = self[0..<self.length - 1]
            suffix = "ies"
        } else if lastChar.lowercased() == "s" || (lastChar.lowercased() == "o" && consonants.filter({x in x == secondToLastChar }).count > 0) {
            prefix = self[0..<self.length]
            suffix = "es"
        } else {
            prefix = self[0..<self.length]
            suffix = "s"
        }
        return prefix + (lastChar != lastChar.uppercased() ? suffix : suffix.uppercased())
    }
    
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
        var str = String(self.characters.reversed())
        str = str.dropFirstWord()
        return String(str.characters.reversed())
    }
    
    func containsOnlyLetters() -> Bool {
        var isValid        = false
        let characterCheck = self.rangeOfCharacter(from: CharacterSet.letters.inverted)
        
        if  characterCheck != nil {
            isValid = false
        } else {
            isValid = true
        }
        
        return isValid
    }
}
