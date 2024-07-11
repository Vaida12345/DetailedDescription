//
//  Protocol + Foundation.swift
//
//
//  Created by Vaida on 7/11/24.
//


public extension CustomDetailedStringConvertible {
    
    var detailedDescription: String {
        let descriptor = DetailedDescription.Descriptor(base: self)
        let descriptions = self.detailedDescription(using: descriptor)
        return descriptions.string
    }
    
}
