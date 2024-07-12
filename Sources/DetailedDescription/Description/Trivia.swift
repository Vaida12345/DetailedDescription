//
//  Trivia.swift
//  
//
//  Created by Vaida on 7/11/24.
//


public enum _Trivia: CustomStringConvertible {
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
        
        static var lastChildSymbol: String {
            "╰"
        }
    }
    
    var symbol: String {
        switch self {
        case .space: " "
        case let .block(block): block.symbol
        case .index(let index): "[\(index)]"
        }
    }
    
    public var description: String {
        switch self {
        case .space: ".space"
        case .block(let block): "." + block.rawValue
        case .index(let index): ".index(\(index))"
        }
    }
}
