//
//  DSLTests.swift
//  DetailedDescription
//
//  Created by Vaida on 8/17/24.
//

import Testing
@testable
import DetailedDescription


struct LoopModel: CustomDetailedStringConvertible {
    
    let dictionary: [String : String]
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<LoopModel>) -> some DescriptionBlockProtocol {
        descriptor.container {
            descriptor.forEach(dictionary) { (key, value) in
                switch 1 {
                case 1:
                    descriptor.string("\(key): \(value)")
                    
                default:
                    descriptor.string("default")
                }
            }
        }
    }
}


