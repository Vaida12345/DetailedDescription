//
//  extenTests.swift
//  
//
//  Created by Vaida on 7/15/24.
//

import Testing
@testable
import DetailedDescription


@Suite("Extension Tests")
struct ExtenTestSuit {
    
    @Test func array() async throws {
        let array = [Int](0..<10)
        
        let match = """
        <10 elements>
         ├─[0]: 0
         ├─[1]: 1
         ├─[2]: 2
         ├─[3]: 3
         ├─[4]: 4
         ├─[5]: 5
         ├─[6]: 6
         ├─[7]: 7
         ├─[8]: 8
         ╰─[9]: 9
        """
        
        #expect(array.detailedDescription == match)
    }
}
