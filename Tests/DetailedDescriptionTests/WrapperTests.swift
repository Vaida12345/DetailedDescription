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


struct NonFinalModelDescriptor: CustomDetailedStringConvertible {
    
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
