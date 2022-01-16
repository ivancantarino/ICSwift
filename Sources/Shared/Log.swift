//
//  Log.swift
//  
//
//  Created by Ivan Cantarino on 15/01/2022.
//

/// A logging function that only compiles while debugging, avoiding
/// logs in the release.
public func Log(_ input: Any = "",
                file: String = #file,
                function: String = #function,
                line: Int = #line,
                alertType: (AlertType)? = nil) {
#if DEBUG
    guard let alert = alertType else {
        print("\n☞ \(input)")
        return
    }
    print("\n\(file):\n\(function) Line \(line)\n\(alert.rawValue)\(input)")
#endif
}

/// Enum that adds and emoji in the beggining of the
/// ICLog string.
/// - `.alert`: "⚠️"
/// - `.error`: "❌ "
/// - `.success`: "✅"
public enum AlertType: String {
    case alert = "⚠️ "
    case error = "❌ "
    case success = "✅ "
}
