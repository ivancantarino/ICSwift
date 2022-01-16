//
//  NotificationCenter.swift
//  
//
//  Created by Ivan Cantarino on 16/01/2022.
//

import Foundation

/// Quality-of-life extension of NotificationCenter.
extension NotificationCenter {
    /// Post a Notification using the `default` center
    /// - Parameters:
    ///   - name: Notification name identifier
    ///   - object: Object to be handled within the notitication
    ///   - userInfo: Aditional information to pass within the notification
    public static func post(_ name: Notification.Name, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
            NotificationCenter.default.post(name: name, object: object, userInfo: userInfo)
    }
}
