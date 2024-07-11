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
            @DetailedDescription.Builder blocks: () -> [Description]
        ) -> Description {
            var blocks = blocks().filter({ !$0.isEmpty })
            var description = Description()
            
            description.add(trivia: [], indicator: "", content: title)
            
            guard !blocks.isEmpty else { return Description() }
            let lastBlock = blocks.removeLast()
            
            for block in blocks {
                description.add(block: block, isLast: false)
            }
            
            description.add(block: lastBlock, isLast: true)
            
            return description
        }
        
        public func value<T>(
            _ title: String? = nil,
            for keyPath: KeyPath<Base, T>
        ) -> Description {
            var description = Description()
            description.add(trivia: [], indicator: (title, keyPath), content: "\(base[keyPath: keyPath])")
            return description
        }
        
        public func value(
            _ content: String
        ) -> Description {
            var description = Description()
            description.add(trivia: [], indicator: "", content: content)
            return description
        }
        
        init(base: Base) {
            self.base = base
        }
    }
    
}
