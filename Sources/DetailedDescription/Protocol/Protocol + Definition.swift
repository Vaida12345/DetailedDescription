//
//  Protocol + Definition.swift
//  
//
//  Created by Vaida on 7/11/24.
//


/// A type with a customized textual representation suitable for detailed display & debugging.
///
/// > remark:
/// > Currently, this protocol does not work on non-`final` `class`.
/// >
/// > Users are recommended to create an intermediate wrapper descriptor `struct`.
/// >
/// > [read more](https://github.com/Vaida12345/DetailedDescription/issues/1)
///
/// ## Topics
/// ### Requirement
/// Structures only need to implement the following.
/// - ``detailedDescription(using:)``
public protocol DetailedStringConvertible: CustomDebugStringConvertible {
    
    /// Use this function to provide description.
    ///
    /// Create the description block.
    ///
    /// - Tip: To create the top level container, please use ``DetailedDescription/Descriptor/container(_:blocks:)``, in which you could make configuration.
    ///
    /// - Parameters:
    ///   - descriptor: The source of block creation.
    ///
    /// - Returns: The built blocks using `descriptor`.
    func detailedDescription(
        using descriptor: DetailedDescription.Descriptor<Self>
    ) -> any DescriptionBlockProtocol
    
}


extension DetailedStringConvertible {
    
    /// The default implementation for debug description: its ``detailedDescription``.
    public var debugDescription: String {
        self.detailedDescription
    }
    
}


@available(*, unavailable, renamed: "DetailedStringConvertible", message: "The protocol has been renamed to a less verbose name.")
public protocol CustomDetailedStringConvertible {

}
