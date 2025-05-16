//
//  DescriptionConfiguration.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-05-16.
//

import Testing
import DetailedDescription


@Suite
struct ConfigurationTests {
    
    struct Model: DetailedStringConvertibleWithConfiguration {
        
        func detailedDescription(
            using descriptor: DetailedDescription.Descriptor<ConfigurationTests.Model>,
            configuration: DescriptionConfiguration
        ) -> any DescriptionBlockProtocol {
            descriptor.container {
                if configuration == .a {
                    descriptor.value("child", of: Model(), configuration: .b)
                } else if configuration == .b {
                    descriptor.value("b", of: Model())
                }
            }
        }
        
        
        enum DescriptionConfiguration: Initializable {
            case a
            case b
            case none
            
            init() {
                self = .none
            }
        }
        
    }
    
    
    @Test func noConfigTest() async throws {
        let model = Model()
        
        let match = """
            Model
            """
        
        #expect(model.detailedDescription() == match)
    }
    
    @Test func configBTest() async throws {
        let model = Model()
        
        let match = """
            Model
             ╰─b: Model
            """
        
        #expect(model.detailedDescription(configuration: .b) == match)
    }
    
    @Test func configATest() async throws {
        let model = Model()
        
        let match = """
            Model
             ╰─child: Model
               ╰─b: Model
            """
        
        #expect(model.detailedDescription(configuration: .a) == match)
    }
}
