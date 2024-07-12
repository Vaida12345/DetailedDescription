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
            let blocks = blocks().filter({ !$0.isEmpty })
            
            var description = DetailedDescription.Description()
            var childrenDescription = DetailedDescription.Description()
            
            
            for block in blocks {
                print(">>", block)
                if block.lines.count > 1 {
                    childrenDescription.add(key: "?what key?", block: block)
                } else {
                    childrenDescription.lines.append(block.lines[0])
                }
            }
            
            description.add(key: title, block: childrenDescription)
            
            return description
        }
        
        public func value<T>(
            _ title: String? = nil,
            for keyPath: KeyPath<Base, T>
        ) -> Description {
            var description = Description()
            description.add(key: (title, keyPath), string: "\(base[keyPath: keyPath])")
            return description
        }
        
        public func value(
            _ content: String
        ) -> Description {
            var description = Description()
            description.add(key: "", string: content)
            return description
        }
        
        init(base: Base) {
            self.base = base
        }
    }
    
}
