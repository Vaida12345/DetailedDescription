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
    ///   - title: The title of the description. When `nil`, the `keyPath` will be used instead.
    ///   - keyPath: The keyPath to the property to be described.
    public func optional<T>(
        _ title: String? = nil,
        for keyPath: KeyPath<Base, Optional<T>>
    ) -> any DescriptionBlockProtocol {
        guard let attribute = base[keyPath: keyPath] else { return OptionalBlock<LineBlock>(block: nil) }
        return OptionalBlock(block: LineBlock(title: title ?? keyPath.trailingPath, value: attribute))
    }
    
}
