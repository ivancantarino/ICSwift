//
//  Double.swift
//  
//
//  Created by Ivan Cantarino on 16/01/2022.
//

import Foundation

extension Double {
    /// Truncate the decimal places to the given input
    /// - Parameter places: The places to truncate the number
    /// - Returns: Returns the new truncated `Double`
    func truncate(places : Int)-> Double {
        Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
