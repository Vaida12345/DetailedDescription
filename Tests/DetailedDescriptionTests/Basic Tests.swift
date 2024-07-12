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
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<Model>) -> some DescriptionBlockProtocol {
        descriptor.container("Model<T>") {
            descriptor.container("details") {
                descriptor.value(for: \.name)
                descriptor.value(for: \.age)
            }
            
            descriptor.value("the end")
        }
    }
}

struct BasicModel: CustomDetailedStringConvertible {
    
    let name: String
    
    let age: Int
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<BasicModel>) -> some DescriptionBlockProtocol {
        descriptor.container("BasicModelModel<T>") {
            descriptor.value(for: \.name)
            descriptor.value(for: \.age)
        }
    }
    
}

struct EmptyModel: CustomDetailedStringConvertible {
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<EmptyModel>) -> some DescriptionBlockProtocol {
        descriptor.container("Model<T>") {
            
        }
    }
}

@Test func testBasic() async throws {
    let model = BasicModel(name: "hello", age: 100)
    let match = """
    BasicModelModel<T>
     ├─name: hello
     ╰─age: 100
    """
    #expect(model.detailedDescription == match)
}


@Test func testNested() async throws {
    let model = Model(name: "hello", age: 100)
    let match = """
    Model<T>
     ├─details
     │ ├─name: hello
     │ ╰─age: 100
     ╰─the end
    """
    
    #expect(model.detailedDescription == match)
}

@Test func testEmpty() {
    let model = EmptyModel()
    
//    dump(model.detailedDescription(using: DetailedDescription.Descriptor<EmptyModel>.init(base: model)))
    
    #expect(model.detailedDescription == "Model<T>")
}
