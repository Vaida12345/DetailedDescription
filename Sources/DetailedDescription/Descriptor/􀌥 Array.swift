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
    /// - Note: setting `serialized` to `true` will hide index.
    ///
    /// - Parameters:
    ///   - title: The title of the description. When `nil`, the `keyPath` will be used instead.
    ///   - keyPath: The keyPath to the sequence to be described.
    ///
    /// - SeeAlso: Read [here](<doc:BlockModifiers>) for a list of modifiers that can be attached to the returned block.
    public func sequence<S: Sequence>(
        _ title: String? = nil,
        for keyPath: KeyPath<Base, S>
    ) -> any DescriptionBlockProtocol {
        self.sequence(title ?? keyPath.trailingPath, of: self.base[keyPath: keyPath])
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
    /// - Note: setting `serialized` to `true` will hide index.
    ///
    /// - Parameters:
    ///   - title: The title of the description.
    ///   - sequence: The sequence to be described.
    ///
    /// - SeeAlso: Read [here](<doc:BlockModifiers>) for a list of modifiers that can be attached to the returned block.
    public func sequence<S: Sequence>(
        _ title: String,
        of sequence: S
    ) -> any DescriptionBlockProtocol {
        LineBlock(
            title: title,
            value: SequenceBlock(
                blocks: sequence.map {
                    LineBlock(title: nil, value: $0)
                }
            )
        )
    }
    
    /// Unfolds the sequence without creating a new hierarchy.
    public func forEach<S: Sequence>(
        _ sequence: S,
        @DetailedDescription.Builder blocks: (S.Element) -> any DescriptionBlockProtocol
    ) -> any DescriptionBlockProtocol {
        FlattenLinesBlock(lines: sequence.map(blocks))
    }
    
}
