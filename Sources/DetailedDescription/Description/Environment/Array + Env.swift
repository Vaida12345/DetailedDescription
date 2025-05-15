//
//  Array + Env.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-05-15.
//

private extension EnvironmentKey {
    static let includeIndex = EnvironmentKey(high: 1, low: 1)
    static let serialized = EnvironmentKey(high: 1, low: 2)
    static let hideEmptySequence = EnvironmentKey(high: 1, low: 3)
}


extension _EnvironmentValues {
    
    var includeIndex: Bool {
        contents[.includeIndex] as? Bool ?? true
    }
    
    var serialized: Bool {
        contents[.serialized] as? Bool ?? false
    }
    
    var hideEmptySequence: Bool {
        contents[.hideEmptySequence] as? Bool ?? false
    }
    
}


public extension DescriptionBlockProtocol {
    
    /// Specifies that `sequence` should hide the index before each element.
    func hideIndex(_ bool: Bool = true) -> any DescriptionBlockProtocol {
        self.environment(.includeIndex, value: !bool)
    }
    
    /// Specifies that `sequence` should be described in the same way that arrays are printed.
    ///
    /// Such as `"header: [1, 2, 3, 4, 5]"`.
    func serialized(_ bool: Bool = true) -> any DescriptionBlockProtocol {
        self.environment(.serialized, value: bool)
    }
    
    /// Specifies that empty `sequence` should be hidden.
    func hideEmptySequence(_ bool: Bool = true) -> any DescriptionBlockProtocol {
        self.environment(.hideEmptySequence, value: bool)
    }
    
}
