//
//  LinesBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


public struct LinesBlock<each T: DescriptionBlockProtocol>: DescriptionBlockProtocol {
    
    let lines: (repeat each T)
    
    public func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        configuration: _Configuration,
        parent: _ParentInfo = []
    ) where Target : TextOutputStream {
        var linesCount = 0
        
        func advanceCounter(_ line: some DescriptionBlockProtocol) {
            guard !line._isEmpty else { return }
            linesCount += 1
        }
        
        repeat advanceCounter(each lines)
        
        var index = 0
        
        func process(_ line: some DescriptionBlockProtocol) {
            guard !line._isEmpty else { return }
            
            let isLastLine = index == linesCount - 1
            
            // trivia inherited
            if !parent.contains(.isLinesBlock) {
                target.write(trivia.map(\.symbol).joined())
            }
            
            let childTrivia: [_Trivia]
            if parent.contains(.isContainer) {
                // new trivia
                target.write(isLastLine ? "╰─" : "├─")
                childTrivia = trivia + (isLastLine ? [.space, .space] : [.block(.vertical), .space])
            } else {
                childTrivia = trivia
            }
            
            line._detailedWrite(to: &target, trivia: childTrivia, configuration: configuration, parent: .isLinesBlock)
            
            if !isLastLine {
                target.write("\n")
            }
            
            index += 1
        }
        
        repeat process(each lines)
    }
    
//    public var _peers: [any DescriptionBlockProtocol] {
//        var peers: [any DescriptionBlockProtocol] = []
//        func getLine(line: some DescriptionBlockProtocol) {
//            peers.append(line)
//        }
//        repeat getLine(line: each lines)
//        return peers
//    }
    
    
    init(lines: (repeat each T)) {
        self.lines = lines
    }
    
}

public struct FlattenLinesBlock<T: DescriptionBlockProtocol>: DescriptionBlockProtocol {
    
    public func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        configuration: _Configuration,
        parent: _ParentInfo
    ) where Target : TextOutputStream {
        for (index, line) in lines.enumerated() {
            guard !line._isEmpty else { continue }
            
            let isLastLine = index == lines.count - 1
            
            // trivia inherited
            if !parent.contains(.isLinesBlock) {
                target.write(trivia.map(\.symbol).joined())
            }
            
            let childTrivia: [_Trivia]
            if parent.contains(.isContainer) {
                // new trivia
                target.write(isLastLine ? "╰─" : "├─")
                childTrivia = trivia + (isLastLine ? [.space, .space] : [.block(.vertical), .space])
            } else {
                childTrivia = trivia
            }
            
            line._detailedWrite(to: &target, trivia: childTrivia, configuration: configuration, parent: .isLinesBlock)
            
            if !isLastLine {
                target.write("\n")
            }
        }
    }
    
    private let lines: [T]
    
    init(lines: [T]) {
        self.lines = lines
    }
    
}
