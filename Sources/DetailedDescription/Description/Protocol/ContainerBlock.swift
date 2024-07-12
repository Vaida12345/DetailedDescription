//
//  ContainerBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


struct ContainerBlock: DescriptionBlockProtocol {
    
    let title: String?
    
    let lines: LinesBlock
    
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia]
    ) where Target : TextOutputStream {
        if let title {
            target.write(title + "\n")
        }
        
        let linesCount = lines.lines.count
        
        var index = 0
        for line in lines.lines {
            guard !(line is EmptyBlock) else { continue }
            
            let isLastLine = index == linesCount - 1
            
            target.write(trivia.map(\.symbol).joined())
            target.write(isLastLine ? "╰─" : "├─")
            
            let childTrivia = trivia + (isLastLine ? [.space, .space] : [.block(.vertical), .space])
            line._detailedWrite(to: &target, trivia: childTrivia)
            
            if !isLastLine {
                target.write("\n")
            }
            
            index += 1
        }
    }
    
}
