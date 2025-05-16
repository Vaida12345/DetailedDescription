//
//  EnvironmentKey.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-05-15.
//


protocol EnvironmentKey {
    
    static var defaultValue: Self.Value { get }
    
    associatedtype Value: Sendable
    
}
