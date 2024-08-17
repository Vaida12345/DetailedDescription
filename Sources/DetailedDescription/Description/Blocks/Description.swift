//
//  DescriptionBlockProtocol.swift
//  
//
//  Created by Vaida on 7/11/24.
//


/// A block of description.
///
/// This is implementation details.
public protocol DescriptionBlockProtocol {
    
    /// When writing, write the heads for children, while `self` remains headless.
    ///
    /// - Parameters:
    ///   - trivia: The leading trivia for its children, if any.
    func _detailedWrite<Target: TextOutputStream>(
        to target: inout Target,
        trivia: [_Trivia],
        configuration: _Configuration,
        parent: _ParentInfo
    )
    
    /// Whether the block is empty
    ///
    /// Empty blocks will not be rendered.
    var _isEmpty: Bool { get }
    
}


extension DescriptionBlockProtocol {
    
    var string: String {
        var string = ""
        self._detailedWrite(to: &string, trivia: [.space], configuration: _Configuration(), parent: [])
        return string
    }
    
    public var _isEmpty: Bool {
        false
    }
    
    func _detailedWrite<Target: TextOutputStream>(
        to target: inout Target,
        trivia: [_Trivia],
        configuration: _Configuration
    ) {
        _detailedWrite(to: &target, trivia: trivia, configuration: configuration, parent: [])
    }
    
}


extension DescriptionBlockProtocol {
    
    func `as`<T>(_ type: T.Type) -> T where T: DescriptionBlockProtocol {
        self as! T
    }
    
}
