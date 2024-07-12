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
    ) -> any DescriptionBlockProtocol {
        guard let attribute = base[keyPath: keyPath] else { return EmptyBlock() }
        
        return LineBlock(title: title ?? keyPath.trailingPath, value: attribute)
    }
    
}
