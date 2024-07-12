//
//  Description.swift
//  
//
//  Created by Vaida on 7/11/24.
//


extension DetailedDescription {
    
    public struct Description {
        
        internal var lines: [Segment]
        
        var isEmpty: Bool {
            self.lines.isEmpty
        }
        
        mutating func add(key: String, string: String) {
            self.lines.append(Segment(key: key, value: .string(string)))
        }
        
        mutating func add<B, T>(key: (String?, KeyPath<B, T>), string: String) {
            self.add(key: key.0 ?? key.1.trailingPath, string: string)
        }
        
        
        mutating func add(key: String, block: Description) {
            self.lines.append(Segment(key: key, value: .block(block)))
        }
        
        mutating func add<B, T>(key: (String?, KeyPath<B, T>), block: Description) {
            self.add(key: key.0 ?? key.1.trailingPath, block: block)
        }
        
        
        mutating func add<Base>(key: String, base: Base) where Base: CustomDetailedStringConvertible {
            let description = base.detailedDescription(using: DetailedDescription.Descriptor<Base>(base: base))
            self.add(key: key, block: description)
        }
        
        mutating func add<Base, B, T>(key: (String?, KeyPath<B, T>), base: Base) where Base: CustomDetailedStringConvertible {
            self.add(key: key.0 ?? key.1.trailingPath, base: base)
        }
        
        
        init(lines: [Segment] = []) {
            self.lines = lines
        }
        
    }
    
}
