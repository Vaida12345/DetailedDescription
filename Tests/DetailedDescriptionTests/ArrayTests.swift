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
        let block = SequenceBlock(blocks: [
            LineBlock(label: "Hello", value: "you"),
            LineBlock(label: "Hello", value: "you too"),
            LineBlock(label: "Hello", value: "you tooo"),
            LineBlock(label: "Hello", value: "you toooo"),
            LineBlock(label: "Hello", value: "you tooooo"),
            LineBlock(label: "Hello", value: "you toooooo"),
            LineBlock(label: "Hello", value: "you tooooooo"),
            LineBlock(label: "Hello", value: "you toooooooo"),
        ])
            .hideIndex()
            .hideEmptySequence()
        
        let match = """
        <8 elements>
         ├─Hello: "you"
         ├─Hello: "you too"
         ├─Hello: "you tooo"
         ├─Hello: "you toooo"
         ├─Hello: "you tooooo"
         ├─Hello: "you toooooo"
         ├─Hello: "you tooooooo"
         ╰─Hello: "you toooooooo"
        """
        
        #expect(block.string == match)
    }
    
    @Test func serialized() async throws {
        let block = descriptor.sequence("header", of: [1, 2, 3, 4, 5])
            .serialized()
        
        let match = """
        header: [1, 2, 3, 4, 5]
        """
        
        #expect(block.string == match)
    }
    
    @Test func index() async throws {
        let block = SequenceBlock(blocks: [
            LineBlock(label: "Hello", value: "you"),
            LineBlock(label: "Hello", value: "you too"),
            LineBlock(label: "Hello", value: "you tooo"),
            LineBlock(label: "Hello", value: "you toooo"),
            LineBlock(label: "Hello", value: "you tooooo"),
            LineBlock(label: "Hello", value: "you toooooo"),
            LineBlock(label: "Hello", value: "you tooooooo"),
            LineBlock(label: "Hello", value: "you toooooooo"),
        ])
            .hideIndex(false)
        
        let match = """
        <8 elements>
         ├─[0]: Hello: "you"
         ├─[1]: Hello: "you too"
         ├─[2]: Hello: "you tooo"
         ├─[3]: Hello: "you toooo"
         ├─[4]: Hello: "you tooooo"
         ├─[5]: Hello: "you toooooo"
         ├─[6]: Hello: "you tooooooo"
         ╰─[7]: Hello: "you toooooooo"
        """
        
        #expect(block.string == match)
    }
    
    @Test func nestedIndex() async throws {
        let block = SequenceBlock(blocks: [
            LineBlock(label: "Hello", value: "you"),
            LineBlock(label: "Hello", value: "you too"),
            LineBlock(label: "Not", raw: .block(ContainerBlock(label: "No", lines: FlattenLinesBlock(lines: [LineBlock(label: "Not", value: "you tooo")])))),
            LineBlock(label: "Hello", value: "you tooo"),
        ])
            .hideEmptySequence()
        
        let match = """
        <4 elements>
         ├─[0]: Hello: "you"
         ├─[1]: Hello: "you too"
         ├─[2]: Not: No
         │      ╰─Not: "you tooo"
         ╰─[3]: Hello: "you tooo"
        """
        
        #expect(block.string == match)
    }
    
    struct Model: DetailedStringConvertible {
        
        let array: [Int]
        
        var count: Int
        
        
        func detailedDescription(using descriptor: DetailedDescription.Descriptor<ArrayTestSuit.Model>) -> any DescriptionBlockProtocol {
            descriptor.container("Model<Array>") {
                descriptor.sequence("_array", for: \.array)
                descriptor.value(for: \.count)
            }
        }
    }
    
    @Test
    func testEmptyModel() async throws {
        let model = Model(array: [Int](repeating: 10, count: 0), count: 3)
        
        let match = """
        Model<Array>
         ├─_array: []
         ╰─count: 3
        """
        
        #expect(match == model.detailedDescription)
    }
    
    @Test
    func testModel() async throws {
        let model = Model(array: [Int](repeating: 10, count: 3), count: 3)
        
        let match = """
        Model<Array>
         ├─_array: <3 elements>
         │ ├─[0]: 10
         │ ├─[1]: 10
         │ ╰─[2]: 10
         ╰─count: 3
        """
        
        #expect(match == model.detailedDescription)
    }
    
    struct LoopModel: DetailedStringConvertible {
        
        let dictionary: [String : String]
        
        func detailedDescription(using descriptor: DetailedDescription.Descriptor<LoopModel>) -> any DescriptionBlockProtocol {
            descriptor.container {
                descriptor.forEach(dictionary) { (key, value) in
                    descriptor.constant("\(key): \(value)")
                }
            }
        }
    }
    
    @Test
    func testLoopModel() async throws {
        let model = LoopModel(dictionary: ["a" : "1"])
        
        let match = """
        LoopModel
         ╰─a: 1
        """
        
        #expect(match == model.detailedDescription)
    }
    
    @Test
    func testFlatten() async throws {
        let block = descriptor.forEach(0..<2) { i in
            descriptor.value("a", of: i)
        }
        
        let match = """
         a: 0
         a: 1
        """
        
        #expect(block.string == match)
    }
    
    @Test
    func testFlatten2() async throws {
        let block = descriptor.container {
            descriptor.forEach(0..<2) { i in
                descriptor.value("a", of: i)
            }
        }
        
        let match = """
        EmptyModel
         ├─a: 0
         ╰─a: 1
        """
        
        #expect(block.string == match)
    }
    
}
