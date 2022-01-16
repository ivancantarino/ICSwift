//
//  UITapGestureRecognizer.swift
//  
//
//  Created by Ivan Cantarino on 15/01/2022.
//

import UIKit

extension UITapGestureRecognizer {
    /// Detects a tap in an attributed text inside the label
    /// - Parameters:
    ///   - label: the `UILabel` to detect the tap
    ///   - targetRange: the range to analyze if the tap occured in
    /// - Returns: Returns `true` if the tap was made within the given range.
    func didTapAttributedTextInLabel(label: UILabel,
                                     inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer,
                                                               in: textContainer,
                                                               fractionOfDistanceBetweenInsertionPoints: nil)        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
