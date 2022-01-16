//
//  Date.swift
//  
//
//  Created by Ivan Cantarino on 16/01/2022.
//

import Foundation

/// Quality-of-life extension of Swift.Date
extension Date {
    /// Returns a string date with the desired format type
    /// - format: The format to output the date
    public func toString(withFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return  formatter.string(from: self)
    }
}
