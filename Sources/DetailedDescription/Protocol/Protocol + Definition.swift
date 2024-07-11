//
//  Protocol + Definition.swift
//  
//
//  Created by Vaida on 7/11/24.
//


public extension DetailedDescription {
    
    protocol DescriptionProtocol {
        
        func detailedDescription(using descriptor: Descriptor<Self>) -> Description
        
    }
    
}


public typealias CustomDetailedStringConvertible = DetailedDescription.DescriptionProtocol
