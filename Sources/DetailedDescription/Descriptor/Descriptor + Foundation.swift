//
//  Descriptor.swift
//  
//
//  Created by Vaida on 7/11/24.
//


extension DetailedDescription {
    
    public struct Descriptor<Base> where Base: CustomDetailedStringConvertible {
        
        let base: Base
        
        
        public func container<each T: DescriptionBlockProtocol>(
            _ title: String,
            @DetailedDescription.Builder blocks: () -> _LinesBlock<repeat each T>
        ) -> some DescriptionBlockProtocol {
            ContainerBlock<repeat each T>(title: title, lines: blocks())
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
