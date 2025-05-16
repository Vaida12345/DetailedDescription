//
//  Config + Foundation.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-05-16.
//

public extension DetailedStringConvertibleWithConfiguration {
    
    /// Use this property to access the detailed description of a ``DetailedStringConvertible``.
    func detailedDescription(configuration: Configuration = Configuration()) -> String {
        let descriptor = DetailedDescription.Descriptor(base: self)
        let descriptions = self.detailedDescription(using: descriptor, configuration: configuration)
        return descriptions.string
    }
    
    
    /// The blocks for debugging use.
    internal func descriptionBlocks() -> any DescriptionBlockProtocol {
        let descriptor = DetailedDescription.Descriptor(base: self)
        return self.detailedDescription(using: descriptor, configuration: Configuration())
    }
    
    /// The blocks for debugging use.
    internal func descriptionBlocks(configuration: Configuration) -> any DescriptionBlockProtocol {
        let descriptor = DetailedDescription.Descriptor(base: self)
        return self.detailedDescription(using: descriptor, configuration: configuration)
    }
    
}
