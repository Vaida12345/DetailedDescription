//
//  Descriptor + Optional.swift
//  
//
//  Created by Vaida on 7/12/24.
//


extension DetailedDescription.Descriptor {
    
    /// Creates a new hierarchy.
    ///
    /// This method is usually used as first line in ``DetailedStringConvertible/detailedDescription(using:)``. However, it can also be used to create new hierarchies.
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
    /// - Parameters:
    ///   - label: The label of the description. When `nil`, the `keyPath` will be used instead.
    ///   - blocks: The DSL for building description.
    public func container(
        _ label: String? = nil,
        @DetailedDescription.Builder blocks: () -> any DescriptionBlockProtocol
    ) -> any DescriptionBlockProtocol {
        ContainerBlock(label: label ?? "\(type(of: self.base))", lines: blocks())
    }
    
}
