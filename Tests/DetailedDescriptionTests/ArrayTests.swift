//
//  ArrayTests.swift
//  
//
//  Created by Vaida on 7/12/24.
//

import Testing
@testable
import DetailedDescription

@Suite
struct ArrayTestSuit {
    @Test func noIndex() async throws {
        let block = ArrayBlock(blocks: [
            LineBlock(title: "Hello", value: "you"),
            LineBlock(title: "Hello", value: "you too"),
            LineBlock(title: "Hello", value: "you tooo"),
            LineBlock(title: "Hello", value: "you toooo"),
            LineBlock(title: "Hello", value: "you tooooo"),
            LineBlock(title: "Hello", value: "you toooooo"),
            LineBlock(title: "Hello", value: "you tooooooo"),
            LineBlock(title: "Hello", value: "you toooooooo"),
        ], includeIndex: false)
        
        let match = """
        <8 elements>
         ├─Hello: you
         ├─Hello: you too
         ├─Hello: you tooo
         ├─Hello: you toooo
         ├─Hello: you tooooo
         ├─Hello: you toooooo
         ├─Hello: you tooooooo
         ╰─Hello: you toooooooo
        """
        
        #expect(block.string == match)
    }
    
    @Test func index() async throws {
        let block = ArrayBlock(blocks: [
            LineBlock(title: "Hello", value: "you"),
            LineBlock(title: "Hello", value: "you too"),
            LineBlock(title: "Hello", value: "you tooo"),
            LineBlock(title: "Hello", value: "you toooo"),
            LineBlock(title: "Hello", value: "you tooooo"),
            LineBlock(title: "Hello", value: "you toooooo"),
            LineBlock(title: "Hello", value: "you tooooooo"),
            LineBlock(title: "Hello", value: "you toooooooo"),
        ], includeIndex: true)
        
        let match = """
        <8 elements>
         ├─[0]: Hello: you
         ├─[1]: Hello: you too
         ├─[2]: Hello: you tooo
         ├─[3]: Hello: you toooo
         ├─[4]: Hello: you tooooo
         ├─[5]: Hello: you toooooo
         ├─[6]: Hello: you tooooooo
         ╰─[7]: Hello: you toooooooo
        """
        
        #expect(block.string == match)
    }
    
    @Test func nestedIndex() async throws {
        let block = ArrayBlock(blocks: [
            LineBlock(title: "Hello", value: "you"),
            LineBlock(title: "Hello", value: "you too"),
            LineBlock(title: "Not", raw: .block(ContainerBlock(title: "No", lines: _LinesBlock(lines: LineBlock(title: "Not", value: "you tooo")), configuration: .init()))),
            LineBlock(title: "Hello", value: "you tooo"),
        ], includeIndex: true)
        
        let match = """
        <4 elements>
         ├─[0]: Hello: you
         ├─[1]: Hello: you too
         ├─[2]: Not: No
         │      ╰─Not: you tooo
         ╰─[3]: Hello: you tooo
        """
        
        #expect(block.string == match)
    }
    
    struct Model: CustomDetailedStringConvertible {
        
        let array: [Int]
        
        var count: Int
        
        
        func detailedDescription(using descriptor: DetailedDescription.Descriptor<ArrayTestSuit.Model>) -> some DescriptionBlockProtocol {
            descriptor.container("Model<Array>") {
                descriptor.array(for: \.array)
                descriptor.value(for: \.count)
            }
        }
    }
    
    @Test
    func testEmptyModel() async throws {
        let model = Model(array: [Int](repeating: 10, count: 0), count: 3)
        
        let match = """
        Model<Array>
         ├─array: []
         ╰─count: 3
        """
        
        #expect(match == model.detailedDescription)
    }
    
    @Test
    func testModel() async throws {
        let model = Model(array: [Int](repeating: 10, count: 3), count: 3)
        
        let match = """
        Model<Array>
         ├─array: <3 elements>
         │ ├─[0]: 10
         │ ├─[1]: 10
         │ ╰─[2]: 10
         ╰─count: 3
        """
        
        #expect(match == model.detailedDescription)
    }
}
