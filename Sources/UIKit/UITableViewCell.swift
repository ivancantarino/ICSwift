//
//  UITableViewCell.swift
//  
//
//  Created by Ivan Cantarino on 15/01/2022.
//

import UIKit

extension UITableViewCell {
    /// Shows or hides the bottom line separator
    /// of the cell.
    /// - Parameter hide: boolean to either show or hide the separator.
    public func separator(hide: Bool) {
        separatorInset.left += hide ? bounds.size.width : 0
    }
}
