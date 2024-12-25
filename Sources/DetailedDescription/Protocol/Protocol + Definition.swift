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
///
/// ### Description
/// Use the following to retrieve the detailed description.
/// - ``detailedDescription``
///
/// ### associatedtype
/// The ``detailedDescription(using:)`` would return `any DescriptionBlockProtocol` when possible.
/// - ``DetailedDescription/DescriptionBlockProtocol``
///
/// ### Builder
/// The build is not applied to ``detailedDescription(using:)``, as it is designed to use ``DetailedDescription/Descriptor/container(_:showType:blocks:)`` on the top level.
/// - ``DetailedDescription/DetailedDescription/Builder``
///
/// ### Descriptor
/// The descriptor for providing the description.
/// - ``DetailedDescription/DetailedDescription/Descriptor``
/// - ``DetailedDescription/DetailedDescription``
public protocol CustomDetailedStringConvertible {
    
    /// Use this function to provide description.
    ///
    /// Create the description block.
    ///
    /// - Tip: To create the top level container, please use ``DetailedDescription/Descriptor/container(_:showType:blocks:)``, in which you could make configuration.
    ///
    /// - Parameters:
    ///   - descriptor: The source of block creation.
    ///
    /// - Returns: The built blocks using `descriptor`.
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<Self>) -> any DescriptionBlockProtocol
    
}
