//
//  K2CollectionTools.swift
//
//  Created by Kailen & Kathryne Engel on 9/18/16.
//  Copyright © 2016 K2. All rights reserved.
//
//  Collection utility functions
//

// create and sorted index of (Character, [String]) from a string array 
typealias Entry = (Character, [String])

func buildIndex(words: [String]) -> [Entry] {
    var tempWords = words.filter { $0 != "" }
    func distinct<T: Equatable>(source: [T]) -> [T] {
        var unique = [T]()
        for item in source {
            if !unique.contains(item) {
                unique.append(item)
            }
        }
        return unique
    }
    
    func firstLetter(str: String) -> Character {
        return str[str.index(str.startIndex, offsetBy: 0)]
    }
    
    return distinct(source: tempWords.map(firstLetter)).map {
        (letter) -> Entry in
        return (letter, tempWords.filter ({
            firstLetter(str: $0) == letter
        }))
    }
}
