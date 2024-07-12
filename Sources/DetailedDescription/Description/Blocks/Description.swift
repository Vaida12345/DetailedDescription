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
        configuration: _Configuration
    )
    
    var _isEmpty: Bool { get }
    
}


extension DescriptionBlockProtocol {
    
    var string: String {
        var string = ""
        self._detailedWrite(to: &string, trivia: [.space], configuration: _Configuration())
        return string
    }
    
    public var _isEmpty: Bool {
        false
    }
    
}
