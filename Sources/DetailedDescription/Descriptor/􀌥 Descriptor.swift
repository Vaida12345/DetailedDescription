//
//  Descriptor.swift
//  
//
//  Created by Vaida on 7/11/24.
//


extension DetailedDescription {
    
    /// A structure used to coordinate and provide the description.
    ///
    /// You do not create descriptors yourself, use the argument from the protocol requirement.
    ///
    /// ## Topics
    /// ### Container
    /// - ``DetailedDescription/Descriptor/container(_:blocks:)``
    ///
    /// ### Describing Value
    /// - ``DetailedDescription/Descriptor/value(_:for:)``
    /// - ``DetailedDescription/Descriptor/value(_:of:)``
    /// - ``DetailedDescription/Descriptor/constant(_:)``
    ///
    /// ### Describing Optional
    /// - ``DetailedDescription/Descriptor/optional(_:for:)``
    /// - ``DetailedDescription/Descriptor/optional(_:of:)``
    ///
    /// ### Describing Sequences
    /// - ``DetailedDescription/Descriptor/sequence(_:for:)``
    /// - ``DetailedDescription/Descriptor/sequence(_:of:)``
    ///
    /// ### ForEach
    /// - ``DetailedDescription/Descriptor/forEach(_:blocks:)``
    public struct Descriptor<Base> where Base: CustomDetailedStringConvertible {
        
        let base: Base
        
        
        init(base: Base) {
            self.base = base
        }
    }
    
}
