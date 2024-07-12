//
//  LineBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


struct LineBlock: DescriptionBlockProtocol {
    
    let title: String?
    
    let value: Value
    
    
    init<T>(title: String?, value: T) {
        self.title = title
        
        if let value = value as? DescriptionBlockProtocol {
            self.value = .block(value)
        } else if let value = value as? CustomStringConvertible {
            self.value = .customStringConvertible(value)
        } else {
            self.value = .string("\(value)")
        }
    }
    
    init(title: String?, raw: Value) {
        self.title = title
        self.value = raw
    }
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia]
    ) where Target : TextOutputStream {
        if let title {
            target.write(title + ": ")
        }
        
        switch value {
        case .string(let string):
            target.write(string)
        case .block(let block):
            block._detailedWrite(to: &target, trivia: trivia)
        case .customStringConvertible(let value):
            target.write(value.description)
        case .none:
            fatalError("Should never evoke")
        }
    }
    
    enum Value {
        case string(String)
        case block(any DescriptionBlockProtocol)
        case customStringConvertible(any CustomStringConvertible)
        case none
        
        var isNone: Bool {
            switch self {
            case .none:
                true
            default:
                false
            }
        }
    }
    
    
    var _isEmpty: Bool {
        self.title == nil && value.isNone
    }
    
    static var empty: LineBlock {
        LineBlock(title: nil, raw: .none)
    }
    
}
