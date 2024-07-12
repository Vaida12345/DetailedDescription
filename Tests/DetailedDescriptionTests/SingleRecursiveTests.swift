//
//  SingleRecursiveTests.swift
//
//
//  Created by Vaida on 7/12/24.
//

import Testing
@testable import DetailedDescription


private indirect enum Node {
    case node(Node)
    case leaf(Int)
    
    var leaf: Int? {
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
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<Node>) -> DetailedDescription.Description {
        descriptor.container("Node<Int>") {
            descriptor.value(for: \.nextNode)
            descriptor.value(for: \.leaf)
        }
    }
    
}


@Test
func testSingleRecursive() async throws {
    let match = """
    Node<Int>
     ╰─nextNode: Node<Int>
        ╰─nextNode: Node<Int>
           ╰─nextNode: Node<Int>
              ╰─leaf: 2
    """
    dump(node.detailedDescription(using: DetailedDescription.Descriptor<Node>(base: node)))
    
    #expect(node.detailedDescription == match)
    
    print(simpleNode.detailedDescription)
}
