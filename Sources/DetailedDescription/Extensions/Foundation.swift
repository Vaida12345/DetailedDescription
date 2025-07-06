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


extension Optional: DetailedStringConvertible where Wrapped: DetailedStringConvertible {
    
    public func detailedDescription(using descriptor: DetailedDescription.Descriptor<Optional<Wrapped>>) -> any DescriptionBlockProtocol {
        if let wrapped = self {
            return descriptor.container("Optional") {
                descriptor.value("", of: wrapped)
            }
        } else {
            return descriptor.constant("nil")
        }
    }
}


extension Optional: DetailedStringConvertibleWithConfiguration where Wrapped: DetailedStringConvertibleWithConfiguration {
    
    public func detailedDescription(using descriptor: DetailedDescription.Descriptor<Optional<Wrapped>>, configuration: DescriptionConfiguration) -> any DescriptionBlockProtocol {
        if let wrapped = self {
            return descriptor.container("Optional") {
                descriptor.value("", of: wrapped)
                    .environment(DescriptionConfiguration.self, value: configuration)
            }
        } else {
            return descriptor.constant("nil")
        }
    }
    
    public typealias DescriptionConfiguration = Wrapped.DescriptionConfiguration
}
