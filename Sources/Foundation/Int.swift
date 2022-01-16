//
//  Int.swift
//  
//
//  Created by Ivan Cantarino on 16/01/2022.
//

import Foundation
import CoreGraphics

extension Int {
    /// Converts the current `Int` to radians (CGFloat)
    public var degreesToRadians: CGFloat { CGFloat(self) * .pi / 180.0 }
}
