//
//  Configuration.swift
//  
//
//  Created by Vaida on 7/12/24.
//


public struct _Configuration {
    
    var showType: Bool?
    
    func mergingKeepingLeft(_ rhs: _Configuration) -> _Configuration {
        _Configuration(
            showType: self.showType ?? rhs.showType
        )
    }
    
    init(showType: Bool? = nil) {
        self.showType = showType
    }
    
}


/// Configuration, but only pass down one level.
public struct _ParentInfo: OptionSet, Sendable {
    
    public let rawValue: UInt
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    
    static let isContainer  = _ParentInfo(rawValue: 1 << 0)
    static let isLinesBlock = _ParentInfo(rawValue: 1 << 1)
    
}
