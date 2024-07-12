//
//  LinesBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


public struct _LinesBlock<each T: DescriptionBlockProtocol>: DescriptionBlockProtocol {
    
    let lines: (repeat each T)
    
    
    public func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia]
    ) where Target : TextOutputStream {
        var needsToWriteNewLine = false
        
        for line in repeat each lines {
            guard !(line is EmptyBlock) else { continue }
            
            if needsToWriteNewLine {
                target.write("\n")
                needsToWriteNewLine = false
            }
            
            line._detailedWrite(to: &target, trivia: trivia)
            needsToWriteNewLine = true
        }
    }
    
}
