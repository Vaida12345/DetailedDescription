//
//  LinesBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


public struct _LinesBlock<each T: DescriptionBlockProtocol>: DescriptionBlockProtocol {
    
    let lines: (repeat each T)
    
    public func _detailedWrite<Target>(to target: inout Target, trivia: [_Trivia], configuration: _Configuration) where Target : TextOutputStream {
        fatalError("Should never call")
    }
    
    public var _peers: [any DescriptionBlockProtocol] {
        var peers: [any DescriptionBlockProtocol] = []
        func getLine(line: some DescriptionBlockProtocol) {
            peers.append(line)
        }
        repeat getLine(line: each lines)
        return peers
    }
    
    
    init(lines: (repeat each T)) {
        self.lines = lines
    }
    
}

public struct _FlattenLinesBlock<T: DescriptionBlockProtocol>: DescriptionBlockProtocol {
    
    public func _detailedWrite<Target>(to target: inout Target, trivia: [_Trivia], configuration: _Configuration) where Target : TextOutputStream {
        fatalError("Should never call")
    }
    
    private let peers: [T]
    
    public var _peers: [any DescriptionBlockProtocol] {
        self.peers
    }
    
    
    init(lines: [T]) {
        self.peers = lines
    }
    
}
