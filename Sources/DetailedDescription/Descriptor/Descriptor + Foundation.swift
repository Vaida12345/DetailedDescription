//
//  Descriptor.swift
//  
//
//  Created by Vaida on 7/11/24.
//


extension DetailedDescription {
    
    public struct Descriptor<Base> where Base: CustomDetailedStringConvertible {
        
        let base: Base
        
        
        public func container(
            _ title: String,
            @DetailedDescription.Builder blocks: () -> LinesBlock
        ) -> some DescriptionBlockProtocol {
            ContainerBlock(title: title, lines: blocks())
        }
        
        public func value<T>(
            _ title: String? = nil,
            for keyPath: KeyPath<Base, T>
        ) -> some DescriptionBlockProtocol {
            LineBlock(title: title ?? keyPath.trailingPath, value: base[keyPath: keyPath])
        }
        
        public func value(
            _ content: String
        ) -> some DescriptionBlockProtocol {
            LineBlock(title: nil, value: content)
        }
        
        init(base: Base) {
            self.base = base
        }
    }
    
}
