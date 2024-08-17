//
//  typeTests.swift
//  
//
//  Created by Vaida on 7/12/24.
//

import Testing
@testable
import DetailedDescription

@Suite
struct TypeTestSuit {
    
    @Test
    func typeTests() {
        let model = BasicModel(name: "dog", age: 11)
        
        let match = """
        BasicModel
         ├─details
         │ ├─name: "dog"
         │ ╰─age: 11
         ╰─name: "dog" <String>
        """
        #expect(model.detailedDescription == match)
    }
    
    struct BasicModel: CustomDetailedStringConvertible {
        
        let name: String
        
        let age: Int
        
        func detailedDescription(using descriptor: DetailedDescription.Descriptor<BasicModel>) -> some DescriptionBlockProtocol {
            descriptor.container(showType: true) {
                descriptor.container("details", showType: false) {
                    descriptor.value(for: \.name)
                    descriptor.value(for: \.age)
                }
                
                descriptor.value(for: \.name)
            }
        }
        
    }
    
}
