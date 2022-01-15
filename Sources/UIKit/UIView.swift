//
//  UIView.swift
//  
//
//  Created by Ivan Cantarino on 15/01/2022.
//

import UIKit

extension UIView {
    /// Position the view within the `superview`
    /// - Parameters:
    ///   - top: Top anchor to fix this view
    ///   - left: Left anchor to fix this view
    ///   - bottom: Bottom anchor to fix this view
    ///   - right: Right anchor to fix this view
    ///   - paddingTop: The distance (gap) on the top, relative to the top anchor
    ///   - paddinfLeft: The distance (gap) on the left, relative to the top anchor
    ///   - paddingBottom: The distance (gap) on the bottom, relative to the top anchor
    ///   - paddingRight: The distance (gap) on the right, relative to the top anchor
    ///   - width: View's `width`. Set only if one of the `Left` or `Right` anchors are `nil`
    ///   - height: View's `height`: Set only if one of the `Top` or  `Bottom` anchors are `nil`
    public func anchor(top: NSLayoutYAxisAnchor? = nil,
                       left: NSLayoutXAxisAnchor? = nil,
                       bottom: NSLayoutYAxisAnchor? = nil,
                       right: NSLayoutXAxisAnchor? = nil,
                       paddingTop: CGFloat = 0,
                       paddinfLeft: CGFloat = 0,
                       paddingBottom: CGFloat = 0,
                       paddingRight: CGFloat = 0,
                       width: CGFloat = 0,
                       height: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddinfLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    /// Center the view within the superview X and Y axis
    /// - Parameter subview: The view which `this` view will be centered relative
    public func center(_ subview: UIView) {
        centerXAnchor.constraint(equalTo: subview.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: subview.centerYAnchor).isActive = true
    }
    
    /// Rounds the corners of the view
    /// - Parameters:
    ///   - corners: the corners to be rounded
    ///   - radius: the radius to round the corners
    public func roundCorners(corners: UIRectCorner,
                             radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    /// Makes this view to match the superview's size.
    /// - Parameter padding: Padding to add to the edges
    public func fillSuperview(_ padding: CGFloat? = nil) {
        self.anchor(top: superview?.topAnchor, left: superview?.leftAnchor, bottom: superview?.bottomAnchor, right: superview?.rightAnchor, paddingTop: padding ?? 0, paddinfLeft: padding ?? 0, paddingBottom: padding ?? 0, paddingRight: padding ?? 0, width: 0, height: 0)
    }
    
    /// Adds an array of views to this view.
    /// - Parameter views: the views to be added as subviews
    public func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    /// Removes the `UIVisualEffectView`, for example
    /// if the view has a `UIBlufEffect` it gets removed
    public func removeBlurEffect() {
        subviews.forEach {
            if $0 is UIVisualEffectView {
                $0.removeFromSuperview()
            }
        }
    }
}
