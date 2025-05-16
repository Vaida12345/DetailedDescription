//
//  Descriptor + Array.swift
//  
//
//  Created by Vaida on 7/12/24.
//


extension DetailedDescription.Descriptor {
    
    /// A description for a sequence.
    ///
    /// This method is used to describe a sequence.
    ///
    /// ```swift
    /// descriptor.sequence("header", of: [1, 2, 3, 4, 5])
    /// // header: <5 elements>
    /// //  ├─[0]: 1
    /// //  ├─[1]: 2
    /// //  ├─[2]: 3
    /// //  ├─[3]: 4
    /// //  ╰─[4]: 5
    /// ```
    ///
    /// - Parameters:
    ///   - label: The label of the description. When `nil`, the `keyPath` will be used instead.
    ///   - keyPath: The keyPath to the sequence to be described.
    ///
    /// - SeeAlso: Read [here](<doc:BlockModifiers>) for a list of modifiers that can be attached to the returned block.
    public func sequence<S: Sequence>(
        _ label: String? = nil,
        for keyPath: KeyPath<Base, S>
    ) -> any DescriptionBlockProtocol {
        self.sequence(label ?? keyPath.trailingPath, of: self.base[keyPath: keyPath])
    }
    
    /// A description for a sequence.
    ///
    /// This method is used to describe a sequence.
    ///
    /// ```swift
    /// descriptor.sequence("header", of: [1, 2, 3, 4, 5])
    /// // header: <5 elements>
    /// //  ├─[0]: 1
    /// //  ├─[1]: 2
    /// //  ├─[2]: 3
    /// //  ├─[3]: 4
    /// //  ╰─[4]: 5
    /// ```
    ///
    /// - Parameters:
    ///   - label: The label of the description.
    ///   - sequence: The sequence to be described.
    ///
    /// - SeeAlso: Read [here](<doc:BlockModifiers>) for a list of modifiers that can be attached to the returned block.
    public func sequence<S: Sequence>(
        _ label: String,
        of sequence: S
    ) -> any DescriptionBlockProtocol {
        LineBlock(
            label: label,
            value: SequenceBlock(
                blocks: sequence.map {
                    LineBlock(label: nil, value: $0)
                }
            )
        )
    }
    
    /// Unfolds the sequence without creating a new hierarchy.
    ///
    /// This method is used to unfold a sequence.
    ///
    /// ```swift
    /// let block = descriptor.container {
    ///     descriptor.forEach(0..<2) { i in
    ///         descriptor.value("a", of: i)
    ///     }
    /// }
    ///
    /// /// descriptor
    /// ///  ├─a: 0
    /// ///  ╰─a: 1
    /// ```
    ///
    /// - Parameters:
    ///   - sequence: The sequence to be mapped.
    ///   - blocks: The result builder for each element in the `sequence`.
    public func forEach<S: Sequence>(
        _ sequence: S,
        @DetailedDescription.Builder blocks: (S.Element) -> any DescriptionBlockProtocol
    ) -> any DescriptionBlockProtocol {
        FlattenLinesBlock(lines: sequence.map(blocks))
    }
    
}


extension DetailedDescription.Descriptor {
    
    /// A description for a sequence.
    ///
    /// This method is used to describe a sequence.
    ///
    /// ```swift
    /// descriptor.sequence("header", of: [1, 2, 3, 4, 5])
    /// // header: <5 elements>
    /// //  ├─[0]: 1
    /// //  ├─[1]: 2
    /// //  ├─[2]: 3
    /// //  ├─[3]: 4
    /// //  ╰─[4]: 5
    /// ```
    ///
    /// - Parameters:
    ///   - label: The label of the description. When `nil`, the `keyPath` will be used instead.
    ///   - keyPath: The keyPath to the sequence to be described.
    ///   - configuration: The configuration for description.
    ///
    /// - SeeAlso: Read [here](<doc:BlockModifiers>) for a list of modifiers that can be attached to the returned block.
    public func sequence<S: Sequence>(
        _ label: String? = nil,
        for keyPath: KeyPath<Base, S>,
        configuration: S.Element.DescriptionConfiguration
    ) -> any DescriptionBlockProtocol where S.Element: DetailedStringConvertibleWithConfiguration {
        self.sequence(label ?? keyPath.trailingPath, of: self.base[keyPath: keyPath], configuration: configuration)
    }
    
    /// A description for a sequence.
    ///
    /// This method is used to describe a sequence.
    ///
    /// ```swift
    /// descriptor.sequence("header", of: [1, 2, 3, 4, 5])
    /// // header: <5 elements>
    /// //  ├─[0]: 1
    /// //  ├─[1]: 2
    /// //  ├─[2]: 3
    /// //  ├─[3]: 4
    /// //  ╰─[4]: 5
    /// ```
    ///
    /// - Parameters:
    ///   - label: The label of the description.
    ///   - sequence: The sequence to be described.
    ///   - configuration: The configuration for description.
    ///
    /// - SeeAlso: Read [here](<doc:BlockModifiers>) for a list of modifiers that can be attached to the returned block.
    public func sequence<S: Sequence>(
        _ label: String,
        of sequence: S,
        configuration: S.Element.DescriptionConfiguration
    ) -> any DescriptionBlockProtocol where S.Element: DetailedStringConvertibleWithConfiguration {
        LineBlock(
            label: label,
            value: SequenceBlock(
                blocks: sequence.map {
                    LineBlock(label: nil, value: $0.descriptionBlocks(configuration: configuration))
                }
            )
        )
    }
    
}
