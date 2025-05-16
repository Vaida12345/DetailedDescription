//
//  DescriptionConfiguration.swift
//  
//
//  Created by Vaida on 7/12/24.
//


/// DescriptionConfiguration, but only pass down one level.
public struct _ParentInfo: OptionSet, Sendable {
    
    public let rawValue: UInt
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    
    static let isContainer  = _ParentInfo(rawValue: 1 << 0)
    static let isLinesBlock = _ParentInfo(rawValue: 1 << 1)
    
}
