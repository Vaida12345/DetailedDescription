//
//  DescriptionBlockProtocol.swift
//  
//
//  Created by Vaida on 7/11/24.
//


/// A block of description.
///
/// This is a implementation detail. This protocol is returned by ``DetailedDescription/Descriptor``.
public protocol DescriptionBlockProtocol {
    
    /// When writing, write the heads for children, while `self` remains headless.
    ///
    /// - Parameters:
    ///   - target: The output stream
    ///   - trivia: The leading trivia for its children, if any.
    ///   - parent: The direct parent. Such parameter is not inherited when propagating values down the stream, expect for `ModifiedBlock`.
    ///   - environment: The environment values, such value is propagated down the stream.
    func _detailedWrite<Target: TextOutputStream>(
        to target: inout Target,
        trivia: [_Trivia],
        parent: _ParentInfo,
        environment: _EnvironmentValues
    )
    
    /// Whether the block is empty
    ///
    /// Empty blocks will not be rendered.
    func _isEmpty(environment: _EnvironmentValues) -> Bool
    
}


extension DescriptionBlockProtocol {
    
    var string: String {
        var string = ""
        self._detailedWrite(
            to: &string,
            trivia: [.space],
            parent: [],
            environment: _EnvironmentValues()
        )
        return string
    }
    
}


extension DescriptionBlockProtocol {
    
    func `as`<T>(_ type: T.Type) -> T where T: DescriptionBlockProtocol {
        self as! T
    }
    
}
