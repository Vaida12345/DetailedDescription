//
//  Protocol + Definition.swift
//  
//
//  Created by Vaida on 7/11/24.
//


public protocol CustomDetailedStringConvertible {
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<Self>) -> DescriptionBlock
    
    associatedtype DescriptionBlock: DescriptionBlockProtocol
    
}
