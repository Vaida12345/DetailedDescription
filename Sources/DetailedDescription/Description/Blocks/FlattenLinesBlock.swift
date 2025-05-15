//
//  FlattenLinesBlock.swift
//  DetailedDescription
//
//  Created by Vaida on 8/17/24.
//


struct FlattenLinesBlock: DescriptionBlockProtocol {
    
    let lines: [any DescriptionBlockProtocol]
    
    func _isEmpty(environment: _EnvironmentValues) -> Bool {
        lines.allSatisfy { $0._isEmpty(environment: environment) }
    }
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        parent: _ParentInfo,
        environment: _EnvironmentValues
    ) where Target : TextOutputStream {
        let count = lines.count(where: { !$0._isEmpty(environment: environment) })
        
        var index = 0
        for line in lines {
            guard !line._isEmpty(environment: environment) else { continue }
            
            let isLastLine = index == count - 1
            
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
            
            line._detailedWrite(to: &target, trivia: childTrivia, parent: .isLinesBlock, environment: environment)
            
            if !isLastLine {
                target.write("\n")
            }
            
            index += 1
        }
    }
    
    init(lines: [any DescriptionBlockProtocol]) {
        var checking: [any DescriptionBlockProtocol] = lines
        var lines: [any DescriptionBlockProtocol] = []
        var i = 0
        while i < checking.count {
            let target = checking[i]
            
            if let target = target as? FlattenLinesBlock {
                checking.append(contentsOf: target.lines)
            } else {
                lines.append(target)
            }
            
            i += 1
        }
        
        self.lines = lines
    }
    
}
