//
//  Protocol + Definition.swift
//  
//
//  Created by Vaida on 7/11/24.
//


/// A type with a customized textual representation suitable for detailed display & debugging.
///
/// ## Topics
/// ### Requirement
/// Structures only need to implement the following.
/// - ``detailedDescription(using:)``
public protocol CustomDetailedStringConvertible {
    
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
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<Self>) -> any DescriptionBlockProtocol
    
}
