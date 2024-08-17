//
//  ArrayBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


struct SequenceBlock: DescriptionBlockProtocol {
    
    let blocks: [LineBlock]
    
    let includeIndex: Bool
    
    let serialized: Bool
    
    let hideEmptySequence: Bool
    
    
    var _isEmpty: Bool {
        hideEmptySequence && blocks.allSatisfy({ $0._isEmpty })
    }
    
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        configuration: _Configuration,
        parent: _ParentInfo = []
    ) where Target : TextOutputStream {
        let blocks = self.blocks.filter({ !$0._isEmpty })
        
        let linesCount = self.blocks.count
        
        if serialized {
            target.write("[")
            for (index, line) in blocks.enumerated() {
                guard !line._isEmpty else { continue }
                
                let isLastLine = index == linesCount - 1
                line._detailedWrite(to: &target, trivia: [], configuration: configuration)
                
                if !isLastLine {
                    target.write(", ")
                }
            }
            target.write("]")
            return
        } else if linesCount != 0 {
            if linesCount == 1 {
                target.write("<\(linesCount) element>")
            } else {
                target.write("<\(linesCount) elements>")
            }
            
            target.write("\n")
        } else {
            target.write("[]")
            return
        }
        
        for (index, line) in blocks.enumerated() {
            guard !line._isEmpty else { continue }
            
            let isLastLine = index == linesCount - 1
            
            target.write(trivia.map(\.symbol).joined())
            target.write(isLastLine ? "╰─" : "├─")
            
            var childTrivia = trivia + (isLastLine ? [.space, .space] : [.block(.vertical), .space])
            
            if includeIndex {
                let _index = "[\(index)]: "
                childTrivia += Array(repeating: .space, count: _index.count)
                target.write(_index)
            }
            
            line._detailedWrite(to: &target, trivia: childTrivia, configuration: configuration)
            
            if !isLastLine {
                target.write("\n")
            }
        }
    }
    
    
    init(blocks: [LineBlock], includeIndex: Bool, serialized: Bool, hideEmptySequence: Bool) {
        self.blocks = blocks
        self.includeIndex = includeIndex
        self.serialized = serialized
        self.hideEmptySequence = hideEmptySequence
    }
    
}
