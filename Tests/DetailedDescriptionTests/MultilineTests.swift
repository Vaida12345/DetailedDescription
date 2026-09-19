//
//  MultilineTests.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-07-06.
//

import Foundation
import Testing
@testable
import DetailedDescription


struct MultilineWrapper<Value>: DetailedStringConvertible {
    
    let value: Value
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<MultilineWrapper<Value>>) -> any DescriptionBlockProtocol {
        descriptor.container {
            descriptor.value(for: \.value)
            descriptor.raw("end")
        }
    }
    
}


@Suite("MultilineTests")
struct MultilineTests {
    
    @Test func int() {
        let value = 123
        let model = MultilineWrapper(value: value)
        let match = """
            MultilineWrapper<Int>
             ├─value: 123
             ╰─end
            """
        #expect(model.detailedDescription == match)
    }
    
    @Test func NSArray() {
        let value = ["1970-01-01 12:00:00 AM +0000" as NSString] as NSArray
        let model = MultilineWrapper(value: value)
        let match = """
            MultilineWrapper<NSArray>
             ├─value: (
             │            "1970-01-01 12:00:00 AM +0000"
             │        )
             ╰─end
            """
        #expect(model.detailedDescription == match)
    }
    
}
