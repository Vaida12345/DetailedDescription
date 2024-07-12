//
//  ArrayBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//



struct ArrayBlock: DescriptionBlockProtocol {
    
    let title: String?
    
    let blocks: [LineBlock]
    
    let includeIndex: Bool
    
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia]
    ) where Target : TextOutputStream {
        if let title {
            target.write(title)
        }
        
        let blocks = self.blocks.filter({ !$0._isEmpty })
        
        let linesCount = self.blocks.count
        
        if linesCount != 0 {
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
            guard !line._isEmpty else { return }
            
            let isLastLine = index == linesCount - 1
            
            target.write(trivia.map(\.symbol).joined())
            target.write(isLastLine ? "╰─" : "├─")
            
            var childTrivia = trivia + (isLastLine ? [.space, .space] : [.block(.vertical), .space])
            
            if includeIndex {
                let _index = "[\(index)]: "
                childTrivia += Array(repeating: .space, count: _index.count)
                target.write(_index)
            }
            
            line._detailedWrite(to: &target, trivia: childTrivia)
            
            if !isLastLine {
                target.write("\n")
            }
        }
    }
    
    
    init(title: String? = nil, blocks: [LineBlock], includeIndex: Bool) {
        self.title = title
        self.blocks = blocks
        self.includeIndex = includeIndex
    }
    
}
