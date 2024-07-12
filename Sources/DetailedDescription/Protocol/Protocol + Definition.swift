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
/// The ``detailedDescription(using:)`` would return `some DescriptionBlockProtocol` when possible.
/// - ``DescriptionBlock``
/// - ``DetailedDescription/DescriptionBlockProtocol``
///
/// ### Builder
/// The build is not applied to ``detailedDescription(using:)``, as it is designed to use ``DetailedDescription/DetailedDescription/Descriptor/container(_:blocks:)`` on the top level.
/// - ``DetailedDescription/DetailedDescription/Builder``
///
/// ### Descriptor:
/// The descriptor for providing the description.
/// - ``DetailedDescription/DetailedDescription/Descriptor``
/// - ``DetailedDescription/DetailedDescription``
public protocol CustomDetailedStringConvertible {
    
    /// Use this function to provide description.
    ///
    /// Create the description block.
    ///
    /// - Tip: To create the top level container, please use ``DetailedDescription/DetailedDescription/Descriptor/container(_:blocks:)``.
    ///
    /// - Parameters:
    ///   - descriptor: The source of block creation.
    ///
    /// - Returns: The built blocks using `descriptor`.
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<Self>) -> DescriptionBlock
    
    /// The provided description block.
    ///
    /// You typically do not interact with this type, use `some DescriptionBlockProtocol` while possible.
    associatedtype DescriptionBlock: DescriptionBlockProtocol
    
}
