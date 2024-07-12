//
//  Description + Add Block.swift
//  
//
//  Created by Vaida on 7/12/24.
//

import Testing
@testable
import DetailedDescription

@Suite
struct Description_AddBlock {
    
    @Test func addStruct() async throws {
        let model = Model(name: "hello", age: 100)
        let block = model.detailedDescription(using: DetailedDescription.Descriptor<Model>(base: model))
        
        var description = DetailedDescription.Description()
        description.add(key: "key", block: block)
        
        let match = """
        key:
         ╰─Model<T>:
           ├─details:
           │ ├─name: hello
           │ ╰─age: 100
           ╰─the end
        """
        
        #expect(description.string == match)
    }
    
}
