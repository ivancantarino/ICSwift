//
//  Collections.swift
//  
//
//  Created by Ivan Cantarino on 16/01/2022.
//

import Foundation

// MARK: - Dictionary

/// Quality-of-life extension of Swift.Dictionary.
extension Dictionary where Value: Equatable {
    func getKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
    
    /// Initializes a new dictionary with the elements of a sequence, creating
    /// keys via a block argument.
    ///
    /// - parameter sequence: The source sequence of elements.
    ///
    /// - parameter block: A block which can generate a key from any given
    /// element in `sequence`.
    ///
    /// - parameter firstWins: If `false`, the last key/value pair overwrites
    /// any previous pair for the same key.
    public init<S: Sequence>(_ sequence: S, usingKeysFrom block: (Value) -> Key, firstWins: Bool = false) where S.Element == Value {
        self = sequence.map(usingKeysFrom: block, firstWins: firstWins)
    }
    
    public init<S: Sequence>(_ sequence: S, using keyPath: KeyPath<Value, Key>, firstWins: Bool = false) where S.Element == Value {
        self = sequence.map(using: keyPath, firstWins: firstWins)
    }
}

// MARK: - Array Extensions

/// Quality-of-life extension of Swift.Array
extension Array {
    /// Appends a element to the array
    func appending(_ item: Element) -> [Element] {
        var copy = self
        copy.append(item)
        return copy
    }
    
    /// Returns a random object from the array
    func random() -> Element? {
        if self.isEmpty { return nil }
        let randomInt = Int(arc4random_uniform(UInt32(self.count)))
        let randomIndex = self.startIndex.advanced(by: randomInt)
        return self[randomIndex]
    }
    
    /// Don't work for free and use swap when indices are next to each other - this
    /// won't rebuild array and will be super efficient.
    mutating func move(from oldIndex: Index, to newIndex: Index) {
        if oldIndex == newIndex { return }
        if abs(newIndex - oldIndex) == 1 { return self.swapAt(oldIndex, newIndex) }
        self.insert(self.remove(at: oldIndex), at: newIndex)
    }
}

extension Array where Element: Equatable {
    mutating func move(_ element: Element, to newIndex: Index) {
        if let oldIndex: Int = self.firstIndex(of: element) { self.move(from: oldIndex, to: newIndex) }
    }
}

/// Quality-of-life extension of RandomAccessCollection.
extension RandomAccessCollection {
    /// A flavor of subscripting that returns an optional element if the index
    /// is out-of-bounds.
    public subscript(optional index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

/// Quality-of-life extension of Sequence.
public extension Sequence {
    /// Maps the receiver to a dictionary using a block to generate keys.
    ///
    /// - parameter block: A block that returns the key for a given element.
    ///
    /// - parameter firstWins: If `false` the last key/value pair overwrites any
    /// previous entries with the same key.
    ///
    /// - returns: Returns a dictionary of elements using the chosen keys.
    func map<Key: Hashable>(usingKeysFrom block: (Element) -> Key, firstWins: Bool = false) -> [Key: Element] {
        let keyValues: [(Key, Element)] = map { (block($0), $0) }
        return Dictionary(keyValues, uniquingKeysWith: { first, last in firstWins ? first : last })
    }
    
    /// Maps the receiver to a dictionary using key paths to generate keys.
    ///
    /// - parameter keyPath: The keyPath to the key for a given element.
    ///
    /// - parameter firstWins: If `false` the last key/value pair overwrites any
    /// previous entries with the same key.
    ///
    /// - returns: Returns a dictionary of elements using the chosen keys.
    func map<Key: Hashable>(using keyPath: KeyPath<Element, Key>, firstWins: Bool = false) -> [Key: Element] {
        let keyValues: [(Key, Element)] = map { ($0[keyPath: keyPath], $0) }
        return Dictionary(keyValues, uniquingKeysWith: { first, last in firstWins ? first : last })
    }
}
