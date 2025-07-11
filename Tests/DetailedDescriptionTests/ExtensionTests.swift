//
//  ExtensionTests.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-07-06.
//

import Foundation
import Testing
@testable
import DetailedDescription


@Suite struct ExtensionTests {
    
    @Test func optionalSome() {
        let model: Model? = Model(name: "123", age: 123)
        let match = """
        Optional
         ╰─Model<T>
           ├─details
           │ ├─name: "123"
           │ ╰─age: 123
           ╰─the end
        """
        #expect(model.detailedDescription == match)
    }
    
    @Test func optionalNone() {
        let model: Model? = nil
        #expect(model.detailedDescription == "nil")
    }
    
}
