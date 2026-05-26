//
//  Config + Recursive.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-06-14.
//

import Testing
import DetailedDescription


@Suite
struct ConfigurationRecursiveTests {
    
    indirect enum Model: DetailedStringConvertibleWithConfiguration {
        
        func detailedDescription(
            using descriptor: DetailedDescription.Descriptor<ConfigurationRecursiveTests.Model>,
            configuration: DescriptionConfiguration
        ) -> any DescriptionBlockProtocol {
            descriptor.container {
                switch self {
                case .left(let model):
                    descriptor.value("left", of: model)
                case .right(let model):
                    descriptor.value("right", of: model)
                case .leaf:
                    descriptor.raw("leaf")
                }
                
                if configuration == .a {
                    descriptor.raw("a")
                } else if configuration == .b {
                    descriptor.raw("b")
                }
            }
        }
        
        case left(Model)
        case right(Model)
        case leaf
        
        
        enum DescriptionConfiguration: Initializable {
            case a
            case b
            case none
            
            init() {
                self = .none
            }
        }
        
    }
    
    
    @Test func recurr() async throws {
        let model = Model.left(.leaf)
        
        let match = """
            Model
             ├─left: Model
             │ ├─leaf
             │ ╰─a
             ╰─a
            """
        
        #expect(model.detailedDescription(configuration: .a) == match)
    }
    
}
