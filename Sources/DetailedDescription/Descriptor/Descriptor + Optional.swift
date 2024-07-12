//
//  Descriptor + Optional.swift
//  
//
//  Created by Vaida on 7/12/24.
//


extension DetailedDescription.Descriptor {
    
    public func value<T>(
        _ title: String? = nil,
        for keyPath: KeyPath<Base, Optional<T>>
    ) -> some DescriptionBlockProtocol {
        guard let attribute = base[keyPath: keyPath] else { return OptionalBlock<LineBlock>(block: nil) }
        return OptionalBlock(block: LineBlock(title: title ?? keyPath.trailingPath, value: attribute))
    }
    
}
