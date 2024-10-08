//
//  Descriptor.swift
//  
//
//  Created by Vaida on 7/11/24.
//


extension DetailedDescription {
    
    /// A structure used to coordinate and provide the description.
    public struct Descriptor<Base> where Base: CustomDetailedStringConvertible {
        
        let base: Base
        
        /// Creates a new hierarchy.
        ///
        /// This method is usually used as first line in ``CustomDetailedStringConvertible/detailedDescription(using:)``. However, it can also be used to create new hierarchies.
        ///
        /// ```swift
        /// descriptor.container("Model") {
        ///     descriptor.container("details") {
        ///         descriptor.value(for: \.name)
        ///         descriptor.value(for: \.age)
        ///     }
        ///
        ///     descriptor.value("the end")
        /// }
        ///
        /// // Model
        /// //  ├─details
        /// //  │ ├─name: "hello"
        /// //  │ ╰─age: 100
        /// //  ╰─the end
        /// ```
        ///
        /// The `showType` parameter can be used to specify whether the *children* should show their types.
        ///
        /// ```swift
        /// descriptor.container(showType: true) {
        ///     descriptor.container("details", showType: false) {
        ///         descriptor.value(for: \.name)
        ///         descriptor.value(for: \.age)
        ///     }
        ///
        ///     descriptor.value(for: \.name)
        /// }
        ///
        /// // BasicModel
        /// //  ├─details
        /// //  │ ├─name: "dog"
        /// //  │ ╰─age: 11
        /// //  ╰─name: "dog" <String>
        /// ```
        ///
        /// Similar to `SwiftUI`, child containers inherit parent configuration if not specified.
        ///
        /// - Parameters:
        ///   - title: The title of the description. When `nil`, the `keyPath` will be used instead.
        ///   - showType: If `true`, the type of its children will be shown. See Discussion for more information.
        ///   - blocks: The DSL for building description.
        public func container(
            _ title: String? = nil,
            showType: Bool? = nil,
            @DetailedDescription.Builder blocks: () -> any DescriptionBlockProtocol
        ) -> any DescriptionBlockProtocol {
            let configuration = _Configuration(showType: showType)
            
            return ContainerBlock(title: title ?? "\(type(of: self.base))", lines: blocks(), configuration: configuration)
        }
        
        /// Annotate the value.
        ///
        /// - Parameters:
        ///   - title: The title of the description. When `nil`, the `keyPath` will be used instead.
        ///   - keyPath: The keyPath to the property to be described.
        public func value<T>(
            _ title: String? = nil,
            for keyPath: KeyPath<Base, T>
        ) -> any DescriptionBlockProtocol {
            LineBlock(title: title ?? keyPath.trailingPath, value: base[keyPath: keyPath])
        }
        
        /// Annotate the value.
        ///
        /// - Tip: ``value(_:for:)`` is preferred when it is possible to access the keyPath.
        ///
        /// - Tip: When you want to pass type-erased optional values `Any?`, explicitly cast `as Any` to show type info.
        ///
        /// - Parameters:
        ///   - title: The title of the description.
        ///   - value: The value to be described.
        public func value<T>(
            _ title: String,
            of value: T
        ) -> any DescriptionBlockProtocol {
            LineBlock(title: title, value: value)
        }
        
        /// Explicitly add a `String`.
        ///
        /// Use this when you want to add an invariant string. For dynamically constructed description, it is recommended to use ``value(_:for:)``
        @available(*, deprecated, renamed: "constant")
        public func string(
            _ content: String
        ) -> any DescriptionBlockProtocol {
            LineBlock(title: nil, raw: .string(content, isString: false))
        }
        
        /// Explicitly add a `String`.
        ///
        /// Use this when you want to add a constant string. For dynamically constructed description, it is recommended to use ``value(_:for:)``
        ///
        /// - Note: `content` will not be bounded by quotation marks.
        public func constant(
            _ content: String
        ) -> any DescriptionBlockProtocol {
            LineBlock(title: nil, raw: .string(content, isString: false))
        }
        
        
        init(base: Base) {
            self.base = base
        }
    }
    
}
