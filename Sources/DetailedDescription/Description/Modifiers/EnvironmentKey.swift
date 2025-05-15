//
//  EnvironmentKey.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-05-15.
//


struct EnvironmentKey: RawRepresentable, Hashable {
    
    var rawValue: UInt64
    
    
    init(rawValue: UInt64) {
        self.rawValue = rawValue
    }
    
    init(high: UInt64, low: UInt64) {
        self.init(rawValue: high << 32 | low)
    }
    
}
