//
//  Descriptor.swift
//  
//
//  Created by Vaida on 7/11/24.
//


extension DetailedDescription {
    
    /// A structure used to coordinate and provide the description.
    public struct Descriptor<Base> where Base: CustomDetailedStringConvertible {
        
        let base: Base
        
        
        init(base: Base) {
            self.base = base
        }
    }
    
}
