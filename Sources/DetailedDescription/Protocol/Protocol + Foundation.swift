//
//  Protocol + Foundation.swift
//
//
//  Created by Vaida on 7/11/24.
//


public extension DetailedStringConvertible {
    
    /// Use this property to access the detailed description of a ``DetailedStringConvertible``.
    var detailedDescription: String {
        let descriptor = DetailedDescription.Descriptor(base: self)
        let descriptions = self.detailedDescription(using: descriptor)
        return descriptions.string
    }
    
    
    /// The blocks for debugging use.
    internal func descriptionBlocks() -> any DescriptionBlockProtocol {
        let descriptor = DetailedDescription.Descriptor(base: self)
        return self.detailedDescription(using: descriptor)
    }
    
}
