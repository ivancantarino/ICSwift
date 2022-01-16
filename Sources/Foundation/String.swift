//
//  File.swift
//  
//
//  Created by Ivan Cantarino on 16/01/2022.
//

import Foundation

public extension String {
    /// Subscript: return the char at index
    subscript (i: Int) -> String {
        self[i ..< i + 1]
    }
    
    /// Subscript: returns a substring from the given range
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                            upper: min(count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
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
