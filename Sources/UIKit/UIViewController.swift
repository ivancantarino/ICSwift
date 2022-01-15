//
//  UIViewController.swift
//  
//
//  Created by Ivan Cantarino on 15/01/2022.
//

import UIKit

extension UIViewController {
    // MARK: - Deallocation
    
    /// Checks if a `UIViewController` was successfully deallocated
    /// after a given amount of seconds.
    /// To test this method just call it within the `viewDidDisappear` method.
    /// - Parameter delay: The delay to check if the `UIViewController` was deallocated.
    public func deallocated(after delay: TimeInterval = 2.0) {
        let rootParentViewController = rootParentViewController

        // We don’t check `isBeingDismissed` simply on this view controller because it’s common
        // to wrap a view controller in another view controller (e.g. in UINavigationController)
        // and present the wrapping view controller instead.
        if isMovingFromParent || rootParentViewController.isBeingDismissed {
            let type = type(of: self)
            let disappearanceSource: String = isMovingFromParent ? Constants.removed.rawValue : Constants.dismissed.rawValue

            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: { [weak self] in
                assert(self == nil, "\(type) not deallocated after being \(disappearanceSource)")
            })
        }
    }

    private var rootParentViewController: UIViewController {
        var root = self

        while let parent = root.parent {
            root = parent
        }

        return root
    }
    
    private enum Constants: String {
        case removed = "Removed from parent"
        case dismissed = "Dismissed"
    }
}
