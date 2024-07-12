//
//  detailedWrite.swift
//  
//
//  Created by Vaida on 7/12/24.
//


//extension DetailedDescription.Description {
//    
//    func detailedWrite<Target: TextOutputStream>(
//        to target: inout Target,
//        trivia: [Segment.Trivia]
//    ) {
//        for (index, line) in self.lines.enumerated() {
//            let isLastLine = index == self.lines.count - 1
//            
//            target.write(trivia.map(\.symbol).joined())
//            
//            let childTrivia: [Segment.Trivia]
//            if !trivia.isEmpty { // if is empty, then must be top level.
//                target.write(isLastLine ? "╰─" : "├─")
//                childTrivia = trivia + (isLastLine ? [.space, .space] : [.block(.vertical), .space])
//            } else {
//                childTrivia = trivia + (isLastLine ? [.space] : [.block(.vertical)])
//            }
//            
//            switch line.value {
//            case let .string(string):
//                if !line.key.isEmpty {
//                    if string.isEmpty {
//                        target.write(line.key + ":")
//                    } else {
//                        target.write(line.key + ": ")
//                    }
//                }
//                
//                target.write(string)
//            case let .block(block):
//                if !line.key.isEmpty {
//                    target.write(line.key + ":")
//                }
//                
//                target.write("\n")
//                block.detailedWrite(to: &target, trivia: childTrivia)
//            }
//            
//            if !isLastLine {
//                target.write("\n")
//            }
//        }
//    }
//    
//    
//    var string: String {
//        var string = ""
//        self.detailedWrite(to: &string, trivia: [])
//        return string
//    }
//    
//}
