//
//  Foundation.swift
//  
//
//  Created by Vaida on 7/15/24.
//


import Foundation


extension Array: CustomDetailedStringConvertible {
    
    public func detailedDescription(using descriptor: DetailedDescription.Descriptor<Array<Element>>) -> some DescriptionBlockProtocol {
        descriptor.sequence("", for: \.self)
    }
    
}
