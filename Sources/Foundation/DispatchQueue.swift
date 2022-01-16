//
//  DispatchQueue.swift
//  
//
//  Created by Ivan Cantarino on 16/01/2022.
//

import Foundation

// Quality-of-life functions to dispatch on any thread.
// This reduces the "friction" on calling the verbose
// `DispatchQueue` functions.

/// DispatchQueue.main.async(execute: block)
public func onMainQueue(_ block: @escaping () -> Void) {
    DispatchQueue.main.async(execute: block)
}

/// DispatchQueue.main.asyncAfter(deadline: DispatchTime)
public func onMainQueueAsyncAfter(_ seconds: TimeInterval, _ block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: block)
}

/// Dispatches on main queue after the current queue; synchronously
public func onMainQueueSyncIfPossible(_ block: @escaping () -> Void) {
    if OperationQueue.current === OperationQueue.main {
        block()
    } else {
        DispatchQueue.main.async(execute: block)
    }
}

/// Dispatched on .global() queue, asychronously after the passed in time.
public func onGlobalQueueAsyncAfter(_ seconds: TimeInterval, _ block: @escaping () -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + seconds, execute: block)
}

/// DispatchQueue.global().async(execute: block); QOS: utility
public func onGlobalQueue(_ block: @escaping () -> Void) {
    DispatchQueue.global(qos: .utility).async(execute: block)
}

/// DispatchQueue.global().async(execute: block) in QOS = userInitiated
public func onGlobalQueueHighPriority(_ block: @escaping () -> Void) {
    DispatchQueue.global(qos: .userInitiated).async(execute: block)
}

/// Dispatches on global queue with the gives Quality Of Service
public func onGlobalQueue(qos: DispatchQoS.QoSClass, _ block: @escaping () -> Void) {
    DispatchQueue.global(qos: qos).async(execute: block)
}
