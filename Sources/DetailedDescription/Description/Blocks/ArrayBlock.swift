//
//  ArrayBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


struct SequenceBlock: DescriptionBlockProtocol {
    
    let blocks: [LineBlock]
    
    
    func _isEmpty(environment: _EnvironmentValues) -> Bool {
        environment.hideEmptySequence && blocks.allSatisfy({ $0._isEmpty(environment: environment) })
    }
    
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        parent: _ParentInfo = [],
        environment: _EnvironmentValues
    ) where Target : TextOutputStream {
        let blocks = self.blocks.filter({ !$0._isEmpty(environment: environment) })
        
        let linesCount = self.blocks.count
        
        if environment.serialized {
            target.write("[")
            for (index, line) in blocks.enumerated() {
                guard !line._isEmpty(environment: environment) else { continue }
                
                let isLastLine = index == linesCount - 1
                line._detailedWrite(to: &target, trivia: [], environment: environment)
                
                if !isLastLine {
                    target.write(", ")
                }
            }
            target.write("]")
            return
        } else {
            if linesCount == 1 {
                target.write("<\(linesCount) element>")
            } else {
                target.write("<\(linesCount) elements>")
            }
            
            if linesCount != 0 {
                target.write("\n")
            }
        }
        
        for (index, line) in blocks.enumerated() {
            guard !line._isEmpty(environment: environment) else { continue }
            
            let isLastLine = index == linesCount - 1
            
            target.write(trivia.map(\.symbol).joined())
            target.write(isLastLine ? "╰─" : "├─")
            
            var childTrivia = trivia + (isLastLine ? [.space, .space] : [.block(.vertical), .space])
            
            if environment.includeIndex {
                let _index = "[\(index)]: "
                childTrivia += Array(repeating: .space, count: _index.count)
                target.write(_index)
            }
            
            line._detailedWrite(to: &target, trivia: childTrivia, environment: environment)
            
            if !isLastLine {
                target.write("\n")
            }
        }
    }
    
}
