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
    
    @Test
    func typeTests2() {
        let model = BasicModel2(name: "dog", age: 11)
        
        let match = """
        BasicModel2
         ├─details
         │ ├─name: "dog" <String>
         │ ╰─age: 11 <Int>
         ╰─name: "dog" <String>
        """
        #expect(model.detailedDescription == match)
    }
    
    struct BasicModel: CustomDetailedStringConvertible {
        
        let name: String
        
        let age: Int
        
        func detailedDescription(using descriptor: DetailedDescription.Descriptor<BasicModel>) -> any DescriptionBlockProtocol {
            descriptor.container(showType: true) {
                descriptor.container("details", showType: false) {
                    descriptor.value(for: \.name)
                    descriptor.value(for: \.age)
                }
                
                descriptor.value(for: \.name)
            }
        }
        
    }
    
    struct BasicModel2: CustomDetailedStringConvertible {
        
        let name: String
        
        let age: Int
        
        func detailedDescription(using descriptor: DetailedDescription.Descriptor<BasicModel2>) -> any DescriptionBlockProtocol {
            descriptor.container(showType: true) {
                descriptor.container("details", showType: nil) {
                    descriptor.value(for: \.name)
                    descriptor.value(for: \.age)
                }
                
                descriptor.value(for: \.name)
            }
        }
        
    }
    
}
