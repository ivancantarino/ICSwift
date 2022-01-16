//
//  UITextView.swift
//  
//
//  Created by Ivan Cantarino on 15/01/2022.
//

import UIKit

extension UITextView {
    /// Centers the text vertically
    public func centerVertically() {
        let fittingSize = CGSize(width: bounds.width,
                                 height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }

    /**    macOS (Catalyst)
        - faz com que não exista um border azul à volta do `UITextView` quando
        este é selecionado (está em destaque).
        - Torna o `_focusRingType` como `0` [NSFocusRingTypeNone].
    */
    
    #if targetEnvironment(macCatalyst)
    @objc(_focusRingType)
    /// Removed the blue border around the `UITextView`
    /// on `macCatalyst` apps, when on focus.
    /// - Devs: turns `_focusRingType` to `0` [NSFocusRingTypeNone].
    var focusRingType: UInt {
        return 1
    }
    #endif
}
