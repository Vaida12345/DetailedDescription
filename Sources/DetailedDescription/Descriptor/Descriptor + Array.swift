//
//  Descriptor + Array.swift
//  
//
//  Created by Vaida on 7/12/24.
//


extension DetailedDescription.Descriptor {
    
    public func array<T>(
        _ title: String? = nil,
        for keyPath: KeyPath<Base, Array<T>>,
        includeIndex: Bool = true
    ) -> some DescriptionBlockProtocol {
        let title = title ?? keyPath.trailingPath
        
        let array = base[keyPath: keyPath]
        
        return LineBlock(title: title, value: ArrayBlock(blocks: array.map { LineBlock(title: nil, value: $0) }, includeIndex: includeIndex))
    }
    
}
