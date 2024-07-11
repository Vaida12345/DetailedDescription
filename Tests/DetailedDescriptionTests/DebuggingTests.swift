//
//  DebuggingTests.swift
//  
//
//  Created by Vaida on 7/12/24.
//

import Testing
@testable
import DetailedDescription


@Suite
struct DebuggingTests {
    
    @Test func symbolNames() async throws {
        #expect(DetailedDescription.Description.Line.Trivia.space.description == ".space")
        #expect(DetailedDescription.Description.Line.Trivia.block(.vertical).description == ".vertical")
        #expect(DetailedDescription.Description.Line.Trivia.block(.child).description == ".child")
        #expect(DetailedDescription.Description.Line.Trivia.block(.lastChild).description == ".lastChild")
        #expect(DetailedDescription.Description.Line.Trivia.block(.dash).description == ".dash")
    }
    
    @Test func descriptionDescription() {
        var description = DetailedDescription.Description()
        description.add(trivia: [.space, .block(.child), .block(.dash)], indicator: "", content: "hello")
        description.add(trivia: [.space, .block(.lastChild), .block(.dash)], indicator: "", content: "you")
        
        let match = """
        -Description
        ├─[.space, .child, .dash] hello
        ╰─[.space, .lastChild, .dash] you
        """
        
        #expect(description.description == match)
    }
    
}
