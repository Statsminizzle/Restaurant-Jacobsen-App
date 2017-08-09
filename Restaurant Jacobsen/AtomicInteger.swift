//
//  AtomicInteger.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 06/08/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import Foundation

public class AtomicInteger {
    private let lock = DispatchSemaphore(value: 1)
    private var value = 0
    
    public func get() -> Int {
        lock.wait()
        defer {
            lock.signal()
        }
        return value
    }
    
    public func set(newValue: Int) {
        lock.wait()
        defer {
            lock.signal()
        }
        value = newValue
    }
    
    public func increment() -> Int {
        lock.wait()
        defer {
            lock.signal()
        }
        value += 1
        return value
    }
}
