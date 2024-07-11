//
//  Trivia.swift
//  
//
//  Created by Vaida on 7/11/24.
//


extension DetailedDescription.Description.Line {
    
    enum Trivia: CustomStringConvertible {
        case space
        case block(Block)
        case index(Int)
        
        enum Block: String {
            case vertical
            case child
            case lastChild
            case dash
            
            var symbol: String {
                switch self {
                case .vertical: "│"
                case .child:  "├"
                case .lastChild: "╰"
                case .dash: "─"
                }
            }
        }
        
        var symbol: String {
            switch self {
            case .space: " "
            case let .block(block): block.symbol
            case .index(let index): "[\(index)]"
            }
        }
        
        var description: String {
            switch self {
            case .space: ".space"
            case .block(let block): "." + block.rawValue
            case .index(let index): ".index(\(index))"
            }
        }
    }
    
}
