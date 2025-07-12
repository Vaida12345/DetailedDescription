//
//  Protocol + Definition.swift
//  
//
//  Created by Vaida on 7/11/24.
//


/// A type with a customized textual representation suitable for detailed display & debugging with an additional configuration type.
///
/// > remark:
/// > Currently, this protocol does not work on non-`final` `class`.
/// >
/// > Users are recommended to create an intermediate wrapper descriptor `struct`.
/// >
/// > [read more](https://github.com/Vaida12345/DetailedDescription/issues/1)
///
/// > Tip:
/// > To store a configuration in the environment, use ``DescriptionBlockProtocol/configuration(_:)`` modifier.
/// >
/// > Any block that can adopt the configuration will use the configuration.
///
/// ## Topics
/// ### Requirement
/// Structures only need to implement the following.
/// - ``detailedDescription(using:configuration:)``
public protocol DetailedStringConvertibleWithConfiguration<DescriptionConfiguration>: CustomDebugStringConvertible {
    
    /// Use this function to provide description.
    ///
    /// Create the description block.
    ///
    /// - Tip: To create the top level container, please use ``DetailedDescription/Descriptor/container(_:blocks:)``, in which you could make configuration.
    ///
    /// - Parameters:
    ///   - descriptor: The source of block creation.
    ///   - configuration: The configuration received.
    ///
    /// - Returns: The built blocks using `descriptor`.
    func detailedDescription(
        using descriptor: DetailedDescription.Descriptor<Self>,
        configuration: DescriptionConfiguration
    ) -> any DescriptionBlockProtocol
    
    
    /// The configuration type that assists in describing.
    associatedtype DescriptionConfiguration: Initializable
    
}


extension DetailedStringConvertibleWithConfiguration {
    
    /// The default implementation for debug description: its ``detailedDescription``.
    public var debugDescription: String {
        self.detailedDescription()
    }
    
}


/// Protocol that can be initialized with default empty parameter.
public protocol Initializable {
    
    /// The default initializer.
    init()
    
}
