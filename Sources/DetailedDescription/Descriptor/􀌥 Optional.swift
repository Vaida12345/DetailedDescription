//
//  Descriptor + Optional.swift
//  
//
//  Created by Vaida on 7/12/24.
//


extension DetailedDescription.Descriptor {
    
    /// A description for an optional value.
    ///
    /// The description block is hidden when the optional value is `nil`. If you want to show `nil`, use ``value(_:for:)``.
    ///
    /// - Parameters:
    ///   - label: The label of the description. When `nil`, the `keyPath` will be used instead.
    ///   - keyPath: The keyPath to the property to be described.
    public func optional<T>(
        _ label: String? = nil,
        for keyPath: KeyPath<Base, T?>
    ) -> any DescriptionBlockProtocol {
        self.optional(label ?? keyPath.trailingPath, of: base[keyPath: keyPath])
    }
    
    /// A description for an optional value.
    ///
    /// The description block is hidden when the optional value is `nil`. If you want to show `nil`, use ``value(_:of:)``.
    ///
    /// - Parameters:
    ///   - label: The label of the description. When `nil`, the `keyPath` will be used instead.
    ///   - keyPath: The keyPath to the property to be described.
    public func optional<T>(
        _ label: String,
        of value: T?
    ) -> any DescriptionBlockProtocol {
        guard let attribute = value else { return OptionalBlock(block: nil) }
        return OptionalBlock(block: LineBlock(label: label, value: attribute))
    }
    
}


extension DetailedDescription.Descriptor {
    
    /// A description for an optional value.
    ///
    /// The description block is hidden when the optional value is `nil`. If you want to show `nil`, use ``value(_:for:)``.
    ///
    /// - Parameters:
    ///   - label: The label of the description. When `nil`, the `keyPath` will be used instead.
    ///   - keyPath: The keyPath to the property to be described.
    ///   - configuration: The configuration for description.
    public func optional<T>(
        _ label: String? = nil,
        for keyPath: KeyPath<Base, T?>,
        configuration: T.Configuration
    ) -> any DescriptionBlockProtocol where T: DetailedStringConvertibleWithConfiguration {
        self.optional(label ?? keyPath.trailingPath, of: base[keyPath: keyPath], configuration: configuration)
    }
    
    /// A description for an optional value.
    ///
    /// The description block is hidden when the optional value is `nil`. If you want to show `nil`, use ``value(_:of:)``.
    ///
    /// - Parameters:
    ///   - label: The label of the description. When `nil`, the `keyPath` will be used instead.
    ///   - keyPath: The keyPath to the property to be described.
    ///   - configuration: The configuration for description. 
    public func optional<T>(
        _ label: String,
        of value: T?,
        configuration: T.Configuration
    ) -> any DescriptionBlockProtocol where T: DetailedStringConvertibleWithConfiguration {
        guard let attribute = value else { return OptionalBlock(block: nil) }
        return OptionalBlock(block: LineBlock(label: label, value: attribute.descriptionBlocks(configuration: configuration)))
    }
    
}
