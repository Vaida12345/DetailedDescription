//
//  Descriptor + Optional.swift
//  
//
//  Created by Vaida on 7/12/24.
//


extension DetailedDescription.Descriptor {
    
    /// Annotate the value.
    ///
    /// - Parameters:
    ///   - label: The label of the description. When `nil`, the `keyPath` will be used instead.
    ///   - keyPath: The keyPath to the property to be described.
    public func value<T>(
        _ label: String? = nil,
        for keyPath: KeyPath<Base, T>
    ) -> any DescriptionBlockProtocol {
        self.value(label ?? keyPath.trailingPath, of: base[keyPath: keyPath])
    }
    
    /// Annotate the value.
    ///
    /// - Tip: ``value(_:for:)`` is preferred when it is possible to access the keyPath.
    ///
    /// - Tip: When you want to pass type-erased optional values `Any?`, explicitly cast `as Any` to show type info.
    ///
    /// - Parameters:
    ///   - label: The label of the description.
    ///   - value: The value to be described.
    public func value<T>(
        _ label: String,
        of value: T
    ) -> any DescriptionBlockProtocol {
        LineBlock(label: label, value: value)
    }
    
    /// Explicitly add a `String`.
    ///
    /// Use this when you want to add a constant string. For dynamically constructed description, it is recommended to use ``value(_:for:)``
    ///
    /// - Note: `content` will not be bounded by quotation marks.
    public func constant(
        _ content: String
    ) -> any DescriptionBlockProtocol {
        LineBlock(label: nil, raw: .string(content, isString: false))
    }
}


extension DetailedDescription.Descriptor {
    
    /// Annotate the value.
    ///
    /// - Parameters:
    ///   - label: The label of the description. When `nil`, the `keyPath` will be used instead.
    ///   - keyPath: The keyPath to the property to be described.
    ///   - configuration: The configuration for description. 
    public func value<T>(
        _ label: String? = nil,
        for keyPath: KeyPath<Base, T>,
        configuration: T.Configuration
    ) -> any DescriptionBlockProtocol where T: DetailedStringConvertibleWithConfiguration {
        self.value(label ?? keyPath.trailingPath, of: base[keyPath: keyPath], configuration: configuration)
    }
    
    /// Annotate the value.
    ///
    /// - Tip: ``value(_:for:)`` is preferred when it is possible to access the keyPath.
    ///
    /// - Tip: When you want to pass type-erased optional values `Any?`, explicitly cast `as Any` to show type info.
    ///
    /// - Parameters:
    ///   - label: The label of the description.
    ///   - value: The value to be described.
    ///   - configuration: The configuration for description.
    public func value<T>(
        _ label: String,
        of value: T,
        configuration: T.Configuration
    ) -> any DescriptionBlockProtocol where T: DetailedStringConvertibleWithConfiguration {
        LineBlock(label: label, value: value.descriptionBlocks(configuration: configuration))
    }
}
