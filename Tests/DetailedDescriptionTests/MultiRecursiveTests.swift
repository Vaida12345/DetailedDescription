//
//  MultiRecursiveTests.swift
//  
//
//  Created by Vaida on 7/12/24.
//

import Testing
@testable import DetailedDescription


private indirect enum Node {
    case node([Node])
    case leaf(Int)
    
    var leaf: Int? {
        switch self {
        case .node:
            nil
        case .leaf(let int):
            int
        }
    }
    
    var nextNodes: [Node] {
        switch self {
        case .node(let node):
            node
        case .leaf:
            []
        }
    }
}


private let node = Node.node([
    .node([
        .leaf(1),
        .node([
            .leaf(2)
        ]),
    ]),
    .leaf(3)
])


extension Node: DetailedStringConvertible {
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<Node>) -> any DescriptionBlockProtocol {
        descriptor.container {
            descriptor.sequence(for: \.nextNodes)
                .hideIndex()
                .hideEmptySequence()
            descriptor.optional(for: \.leaf)
        }
        .hideIndex(false)
    }
    
}

@Test
func testMultiRecursive() async throws {
    let match = """
    Node
     ╰─nextNodes: <2 elements>
       ├─Node
       │ ╰─nextNodes: <2 elements>
       │   ├─Node
       │   │ ╰─leaf: 1
       │   ╰─Node
       │     ╰─nextNodes: <1 element>
       │       ╰─Node
       │         ╰─leaf: 2
       ╰─Node
         ╰─leaf: 3
    """
    
    #expect(node.detailedDescription == match)
}
