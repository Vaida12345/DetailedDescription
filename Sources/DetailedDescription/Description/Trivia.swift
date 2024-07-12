//
//  Trivia.swift
//  
//
//  Created by Vaida on 7/11/24.
//


public enum _Trivia {
    case space
    case block(_Block)
    case index(Int)
    
    public enum _Block: String {
        case vertical
        case child
        case dash
        
        var symbol: String {
            switch self {
            case .vertical: "│"
            case .child:  "├"
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
}
