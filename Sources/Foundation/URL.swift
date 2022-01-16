//
//  URL.swift
//  
//
//  Created by Ivan Cantarino on 16/01/2022.
//

import MobileCoreServices
import Foundation

extension URL {
    /// Gets the file name of the URL's last path component
    /// **Example:** `filename.txt` returns `filename`
    public func getFileName() -> String {
        let text = lastPathComponent
        let till: Character = "."
        var _return: String = ""

        if let idx = text.firstIndex(of: till) {
            let charPosition = text.distance(from: text.startIndex, to: idx)
            let index = text.index(text.startIndex, offsetBy: charPosition)
            _return = String(text[..<index])
            return _return
        }
        return ""
    }
        
    /// Gets the file extension of the URL's last path component
    /// **Example:** `filename.txt` returns `txt`
    public func getFileExtension() -> String {
        let text = lastPathComponent
        let till: Character = "."
        
        if let idx = text.lastIndex(of: till) {
            let i = text.index(idx, offsetBy: 1)
            return String(text[i..<text.endIndex])
        }
        return ""
    }
    
    /// Returns the file size, from URL in megabytes.
    public func getFileSizeInMB() -> Double {
        var size: Double = -1.0
        do {
            let resources = try resourceValues(forKeys: [.fileSizeKey])
            guard let fileSizeInBytes = resources.fileSize else { return size }
            size = Double(fileSizeInBytes) / 1000000.0
        } catch {}
        return size
    }
}
