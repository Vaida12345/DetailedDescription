//
//  Array + Env.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-05-15.
//

private struct IncludeIndexEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool = true
}

private struct SerializedEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

private struct HideEmptySequenceEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool = false
}


extension _EnvironmentValues {
    
    var includeIndex: Bool {
        get { self[IncludeIndexEnvironmentKey.self] }
        set { self[IncludeIndexEnvironmentKey.self] = newValue }
    }
    
    var serialized: Bool {
        get { self[SerializedEnvironmentKey.self] }
        set { self[SerializedEnvironmentKey.self] = newValue }
    }
    
    var hideEmptySequence: Bool {
        get { self[HideEmptySequenceEnvironmentKey.self] }
        set { self[HideEmptySequenceEnvironmentKey.self] = newValue }
    }
    
}


public extension DescriptionBlockProtocol {
    
    /// Specifies that `sequence` should hide the index before each element.
    func hideIndex(_ bool: Bool = true) -> any DescriptionBlockProtocol {
        self.environment(IncludeIndexEnvironmentKey.self, value: !bool)
    }
    
    /// Specifies that `sequence` should be described in the same way that arrays are printed.
    ///
    /// Such as `"header: [1, 2, 3, 4, 5]"`.
    ///
    /// - Note: setting `serialized` to `true` will hide index.
    func serialized(_ bool: Bool = true) -> any DescriptionBlockProtocol {
        self.environment(SerializedEnvironmentKey.self, value: bool)
    }
    
    /// Specifies that empty `sequence` should be hidden.
    func hideEmptySequence(_ bool: Bool = true) -> any DescriptionBlockProtocol {
        self.environment(HideEmptySequenceEnvironmentKey.self, value: bool)
    }
    
}
