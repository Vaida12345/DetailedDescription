//
//  SingleRecursiveTests.swift
//
//
//  Created by Vaida on 7/12/24.
//

import Testing
@testable import DetailedDescription


private indirect enum Node : Sendable{
    case node(Node)
    case leaf(Int)
    
    var isLeaf: Int? {
        switch self {
        case .node:
            nil
        case .leaf(let int):
            int
        }
    }
    
    var nextNode: Node? {
        switch self {
        case .node(let node):
            node
        case .leaf:
            nil
        }
    }
}


private let node = Node.node(
    .node(
        .node(
            .leaf(
                2
            )
        )
    )
)

private let simpleNode = Node.node(
    .leaf(
        2
    )
)


extension Node: CustomDetailedStringConvertible {
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<Node>) -> any DescriptionBlockProtocol {
        descriptor.container("Node<Int>") {
            descriptor.optional(for: \.nextNode)
            descriptor.optional(for: \.isLeaf)
        }
    }
    
}


@Test
func testSingleRecursive() throws {
    let match = """
    Node<Int>
     ╰─nextNode: Node<Int>
       ╰─nextNode: Node<Int>
         ╰─nextNode: Node<Int>
           ╰─isLeaf: 2
    """
    
    #expect(node.detailedDescription == match)
}
