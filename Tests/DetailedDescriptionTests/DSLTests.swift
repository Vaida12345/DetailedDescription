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
    
    let index: Int
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<LoopModel>) -> any DescriptionBlockProtocol {
        descriptor.container {
            if index == 0 {
                descriptor.value("", of: "2")
            } else if index == 1 {
                //                    if dictionary.count == 0 {
                //                        descriptor.value("", of: "2")
                //                    } else {
                //                        descriptor.value("", of: "1")
                //                    }
            } else {
                
            }
        }
    }
}


@Test func testLoopModel() async throws {
    let model = LoopModel(dictionary: ["a" : "1"], index: 2)
    let match = """
    LoopModel
    """
    
    #expect(model.detailedDescription == match)
}


