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
    ///   - includeIndex: If `true`, specifies the index before each element. Defaults to `true`, as shown by the sample code.
    ///   - hideEmptySequence: If `true`, empty sequences will be hidden. If `nil`, empty sequences are hidden when `S.Element` is `CustomDetailedStringConvertible`
    ///   - serialized: If `true`, the sequence will be described in the same way that arrays are printed. The result of sample code would become `"header: [1, 2, 3, 4, 5]"`.
    public func sequence<S: Sequence>(
        _ title: String? = nil,
        for keyPath: KeyPath<Base, S>,
        includeIndex: Bool = true,
        hideEmptySequence: Bool? = nil,
        serialized: Bool = false
    ) -> any DescriptionBlockProtocol {
        self.sequence(title ?? keyPath.trailingPath, of: self.base[keyPath: keyPath], includeIndex: includeIndex, hideEmptySequence: hideEmptySequence, serialized: serialized)
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
    /// - Tip: ``sequence(_:for:includeIndex:hideEmptySequence:serialized:)`` is preferred when it is possible to access the keyPath.
    ///
    /// - Parameters:
    ///   - title: The title of the description.
    ///   - sequence: The sequence to be described.
    ///   - includeIndex: If `true`, specifies the index before each element. Defaults to `true`, as shown by the sample code.
    ///   - hideEmptySequence: If `true`, empty sequences will be hidden. If `nil`, empty sequences are hidden when `S.Element` is `CustomDetailedStringConvertible`
    ///   - serialized: If `true`, the sequence will be described in the same way that arrays are printed. The result of sample code would become `"header: [1, 2, 3, 4, 5]"`.
    public func sequence<S: Sequence>(
        _ title: String,
        of sequence: S,
        includeIndex: Bool = true,
        hideEmptySequence: Bool? = nil,
        serialized: Bool = false
    ) -> any DescriptionBlockProtocol {
        LineBlock(
            title: title,
            value: SequenceBlock(
                blocks: sequence.map {
                    LineBlock(title: nil, value: $0)
                },
                includeIndex: includeIndex,
                serialized: serialized,
                hideEmptySequence: hideEmptySequence ?? (S.Element.self is any CustomDetailedStringConvertible.Type ? true : false)
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
