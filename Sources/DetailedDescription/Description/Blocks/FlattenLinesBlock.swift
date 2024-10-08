//
//  FlattenLinesBlock.swift
//  DetailedDescription
//
//  Created by Vaida on 8/17/24.
//


struct FlattenLinesBlock: DescriptionBlockProtocol {
    
    let lines: [any DescriptionBlockProtocol]
    
    var _isEmpty: Bool {
        lines.allSatisfy(\._isEmpty)
    }
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        configuration: _Configuration,
        parent: _ParentInfo
    ) where Target : TextOutputStream {
        let count = lines.count(where: { !$0._isEmpty })
        
        var index = 0
        for line in lines {
            guard !line._isEmpty else { continue }
            
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
            
            line._detailedWrite(to: &target, trivia: childTrivia, configuration: configuration, parent: .isLinesBlock)
            
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
            } else if let target = target as? AnyBlock {
                checking.append(target.block)
            } else if let target = (target as? OptionalBlock)?.block {
                checking.append(target)
            } else {
                lines.append(target)
            }
            
            i += 1
        }
        
        self.lines = lines
    }
    
}
