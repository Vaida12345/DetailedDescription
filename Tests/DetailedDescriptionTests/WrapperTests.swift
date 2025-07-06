//
//  WrapperTests.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-05-15.
//


import Testing
import DetailedDescription
import Foundation


class NonFinalModel {
    
    let name = "12345"
    
}


struct NonFinalModelDescriptor: DetailedStringConvertible {
    
    let model: NonFinalModel
    
    func detailedDescription(
        using descriptor: DetailedDescription.Descriptor<NonFinalModelDescriptor>
    ) -> any DescriptionBlockProtocol {
        descriptor.container {
            descriptor.value(for: \.model.name)
        }
    }
    
}


@Test
func testNonFinalModelWrapper() {
    
    let match = """
        NonFinalModelDescriptor
         ╰─name: "12345"
        """
    let descriptor = NonFinalModelDescriptor(model: NonFinalModel())
    
    #expect(descriptor.detailedDescription == match)
    
}



struct Wrapper<Value>: DetailedStringConvertible {
    
    let value: Value
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<Wrapper<Value>>) -> any DescriptionBlockProtocol {
        descriptor.value(for: \.value)
    }
    
}


@Suite struct WrapperTests {
    
    @Test func any() {
        let value: Any = "Hello, World!"
        #expect(Wrapper(value: value).detailedDescription == "value: \"Hello, World!\"")
    }
    
    @Test func NSDate() {
        let value: Any = Date(timeIntervalSince1970: 0) as NSDate
        #expect(Wrapper(value: value).detailedDescription == "value: \(value as! Date)")
    }
    
}
