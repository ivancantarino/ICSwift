//
//  FileManager.swift
//  
//
//  Created by Ivan Cantarino on 16/01/2022.
//

import Foundation

/// Convenience methods extending FileManager. These swallow errors you don't
/// care to know the details about, or force-unwrap things that should never be
/// nil in practice (where a crash would be preferable to undefined behavior).
public extension FileManager {
    /// Direct access to the `cachesDirectory`
    /// - Returns: return the `cachesDirectory` URL
    func cachesDirectory() -> URL {
#if os(iOS) || os(watchOS)
        return urls(for: .cachesDirectory, in: .userDomainMask).first!
#elseif os(OSX)
        let library = urls(for: .libraryDirectory, in: .userDomainMask).first!
        return library.appendingPathComponent("Caches", isDirectory: true)
#endif
    }
    
    /// Direct access to the `documentsDirectory`
    /// - Returns: return the `documentsDirectory` URL
    func documentsDirectory() -> URL {
        return urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    /// Creates a directory at the specified URL
    /// - Parameter url: The URL destination to create the directory
    /// - Returns: Returns `true` if the directory was successfully created
    func createDirectory(at url: URL) -> Bool {
        do {
            try createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil
            )
            return true
        } catch {
            return false
        }
    }
    
    /// Creates a subdirectory at the specified URL
    /// - Parameters:
    ///   - name: Folder name to be created
    ///   - url: The parent URL where the subdirectory is going to be created
    /// - Returns: Returns `true` if the subdirectory was successfully created
    func createSubdirectory(named name: String, atUrl url: URL) -> Bool {
        let subdirectoryUrl = url.appendingPathComponent(name, isDirectory: true)
        return createDirectory(at: subdirectoryUrl)
    }
    
    /// Removes the directory at the specified URL
    /// - Parameter directory: The directory URL to be removed
    /// - Returns: Returns `true` if the directory was successfully removed
    func removeDirectory(_ directory: URL) -> Bool {
        do {
            try removeItem(at: directory)
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult
    /// Removes a file at the specified URL
    /// - Parameter url: The URL of the file to be removed
    /// - Returns: Returns `true` if the file was successfully removed
    func removeFile(at url: URL) -> Bool {
        do {
            try removeItem(at: url)
            return true
        } catch {
            return false
        }
    }
    
    /// Checks if a file exists at the specified URL
    /// - Parameter url: The URL to analyze the file's existance
    /// - Returns: Returns `true` if the file exists at the URL
    func fileExists(at url: URL) -> Bool {
        return fileExists(atPath: url.path)
    }
    
    /// Moves a file from a `URL` to another `URL`
    /// - Parameters:
    ///   - from: The origin URL to move the file from
    ///   - to: The destination URL to move the file to
    func moveFile(from: URL, to: URL) throws {
        if fileExists(at: to) {
            _ = try replaceItemAt(to, withItemAt: from)
        } else {
            _ = try moveItem(at: from, to: to)
        }
    }
    
    /// Removes any files from a given `URL` until a defined byte limit.
    /// - Parameters:
    ///   - directory: The directory to remove the files from
    ///   - limit: The `byte` limit to remove the files
    func removeFilesByDate(inDirectory directory: URL, untilWithinByteLimit limit: UInt) {
        struct Item {
            let url: NSURL
            let fileSize: UInt
            let dateModified: Date
        }
        
        let keys: [URLResourceKey] = [.fileSizeKey, .contentModificationDateKey]
        
        guard let urls = try? contentsOfDirectory(at: directory,
                                                  includingPropertiesForKeys: keys,
                                                  options: .skipsHiddenFiles)
        else { return }
        
        let items: [Item] = (urls as [NSURL])
            .compactMap { url -> Item? in
                guard let values = try? url.resourceValues(forKeys: keys) else { return nil }
                return Item(
                    url: url,
                    fileSize: (values[.fileSizeKey] as? NSNumber)?.uintValue ?? 0,
                    dateModified: (values[.contentModificationDateKey] as? Date) ?? Date.distantPast
                )
            }
            .sorted { $0.dateModified < $1.dateModified }
        
        var total = items.map { $0.fileSize }.reduce(0, +)
        var toDelete = [Item]()
        for item in items {
            guard total > limit else { break }
            total -= item.fileSize
            toDelete.append(item)
        }
        
        toDelete.forEach {
            _ = try? self.removeItem(at: $0.url as URL)
        }
    }
    
}

private func didntThrow(_ block: () throws -> Void) -> Bool {
    do { try block(); return true } catch { return false }
}
