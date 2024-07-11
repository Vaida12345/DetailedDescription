//
//  DetailedDescriptionTests.swift
//
//
//  Created by Vaida on 7/12/24.
//

import Testing
@testable 
import DetailedDescription

struct Model: CustomDetailedStringConvertible {
    
    let name: String
    
    let age: Int
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<Model>) -> DetailedDescription.Description {
        descriptor.container("Model<T>") {
            descriptor.container("details") {
                descriptor.value(for: \.name)
                descriptor.value(for: \.age)
            }
            
            descriptor.value("the end")
        }
    }
    
}


@Test func example() async throws {
    let model = Model(name: "hello", age: 100)
    let match = """
    Model<T>
     ├─details
     │  ├─name: hello
     │  ╰─age: 100
     ╰─the end
    """
    #expect(model.detailedDescription == match)
}
