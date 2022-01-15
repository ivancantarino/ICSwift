//
//  UIAlertController.swift
//  
//
//  Created by Ivan Cantarino on 15/01/2022.
//

import UIKit

extension UIAlertController {
    /// Adds an arrary of actions to the `UIAlertController`
    /// - Parameter actions: The actions to be added
    public func addActions(_ actions: [UIAlertAction]) {
        actions.forEach { addAction($0) }
    }
}
