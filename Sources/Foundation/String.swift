//
//  File.swift
//  
//
//  Created by Ivan Cantarino on 16/01/2022.
//

import Foundation

public extension String {
    subscript (i: Int) -> String {
        self[i ..< i + 1]
    }
    
    /// Converts the given string to a substring staring
    /// from the specified index
    /// - Parameter fromIndex: The index to start the substring from
    /// - Returns: Returns the final substring'ed version of `self`.
    func substring(fromIndex: Int) -> String {
        self[min(fromIndex, count) ..< count]
    }
    
    /// Converts the given string to a substring up to
    /// the given index.
    /// - Parameter toIndex: The limit index to substring to
    /// - Returns: Returns the final substring'ed version of `self`
    func substring(toIndex: Int) -> String {
        self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                            upper: min(count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    /// Returns the Character at the given index
    func getCharAtIndex(_ index: Int) -> Character {
        self[self.index(self.startIndex, offsetBy: index)]
    }
    
    /// Capitalizes the first letter
    /// - Returns: Returns `self` with the first letter capitalized
    func capitalizingFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    /// Access to the given localized file to convert
    /// to the respective language.
    /// - Returns: Returns `self` converted to the specified language
    func localized() -> String {
        NSLocalizedString(self,
                          tableName: "Localizable",
                          bundle: .main,
                          value: self,
                          comment: self
        )
    }
}
