//
//  Foundation.swift
//  
//
//  Created by Vaida on 7/15/24.
//


import Foundation


extension Array: DetailedStringConvertible {
    
    public func detailedDescription(using descriptor: DetailedDescription.Descriptor<Array<Element>>) -> any DescriptionBlockProtocol {
        descriptor.sequence("", for: \.self)
    }
    
}
