//
//  ContainerBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//

import Foundation


struct ContainerBlock<each T: DescriptionBlockProtocol>: DescriptionBlockProtocol {
    
    let title: String?
    
    let lines: _LinesBlock<repeat each T>
    
    let configuration: _Configuration
    
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        configuration: _Configuration
    ) where Target : TextOutputStream {
        if let title {
            target.write(title)
        }
        
        var linesCount = 0
        
        func advanceCounter(_ line: some DescriptionBlockProtocol) {
            guard !line._isEmpty else { return }
            linesCount += 1
        }
        
        repeat advanceCounter(each lines.lines)
        
        if linesCount != 0 {
            target.write("\n")
        }
        
        var index = 0
        
        func process(_ line: some DescriptionBlockProtocol) {
            guard !line._isEmpty else { return }
            
            let isLastLine = index == linesCount - 1
            
            target.write(trivia.map(\.symbol).joined())
            target.write(isLastLine ? "╰─" : "├─")
            
            let childTrivia = trivia + (isLastLine ? [.space, .space] : [.block(.vertical), .space])
            line._detailedWrite(to: &target, trivia: childTrivia, configuration: self.configuration.showType != nil ? self.configuration : configuration)
            
            if !isLastLine {
                target.write("\n")
            }
            
            index += 1
        }
        
        repeat process(each lines.lines)
    }
    
}
