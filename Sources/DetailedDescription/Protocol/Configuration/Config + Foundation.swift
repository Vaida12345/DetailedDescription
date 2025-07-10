//
//  Config + Foundation.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-05-16.
//

public extension DetailedStringConvertibleWithConfiguration {
    
    /// Use this property to access the detailed description of a ``DetailedStringConvertible``.
    func detailedDescription(configuration: DescriptionConfiguration = DescriptionConfiguration()) -> String {
        let descriptor = DetailedDescription.Descriptor(base: self)
        let descriptions = self.detailedDescription(using: descriptor, configuration: configuration)
            .configuration(configuration)
        return descriptions.string
    }
    
    
    /// The blocks for debugging use.
    internal func descriptionBlocks() -> any DescriptionBlockProtocol {
        let descriptor = DetailedDescription.Descriptor(base: self)
        return self.detailedDescription(using: descriptor, configuration: DescriptionConfiguration())
    }
    
    /// The blocks for debugging use.
    internal func descriptionBlocks(configuration: DescriptionConfiguration) -> any DescriptionBlockProtocol {
        let descriptor = DetailedDescription.Descriptor(base: self)
        return self.detailedDescription(using: descriptor, configuration: configuration)
    }
    
}
