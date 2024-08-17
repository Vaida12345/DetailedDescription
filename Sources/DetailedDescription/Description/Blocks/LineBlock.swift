//
//  LineBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


struct LineBlock: DescriptionBlockProtocol {
    
    let title: String?
    
    let value: Value
    
    let type: String
    
    init<T>(title: String?, value: T) {
        self.title = title
        self.type = "\(Swift.type(of: value as Any))"
        
        if let value = value as? (any DescriptionBlockProtocol) {
            self.value = .block(value)
        } else if let value = value as? (any CustomDetailedStringConvertible) {
            self.value = .customDetailedStringConvertible(value)
        } else if let value = value as? String {
            self.value = .string("\"\(value)\"")
        } else if let value = value as? CustomStringConvertible {
            self.value = .customStringConvertible(value)
        } else {
            self.value = .string("\(value)")
        }
    }
    
    init(title: String?, raw: Value) {
        self.type = ""
        self.title = title
        self.value = raw
    }
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        configuration: _Configuration,
        parent: _ParentInfo = []
    ) where Target : TextOutputStream {
        if let title {
            target.write(title)
            if !title.isEmpty {
                target.write(": ")
            }
        }
        
        switch value {
        case .string(let string):
            target.write(string)
            if configuration.showType ?? false {
                target.write(" <\(type)>")
            }
        case .block(let block):
            block._detailedWrite(to: &target, trivia: trivia, configuration: configuration)
        case .customDetailedStringConvertible(let value):
            value.descriptionBlocks()._detailedWrite(to: &target, trivia: trivia, configuration: configuration)
        case .customStringConvertible(let value):
            target.write(value.description)
            if configuration.showType ?? false {
                target.write(" <\(type)>")
            }
        case .none:
            fatalError("Should never evoke")
        }
    }
    
    enum Value {
        case string(String)
        case block(any DescriptionBlockProtocol)
        case customStringConvertible(any CustomStringConvertible)
        case customDetailedStringConvertible(any CustomDetailedStringConvertible)
        case none
        
        var isNone: Bool {
            switch self {
            case .none:
                true
            case let .block(block):
                block._isEmpty
            default:
                false
            }
        }
    }
    
    
    var _isEmpty: Bool {
        value.isNone
    }
    
    static var empty: LineBlock {
        LineBlock(title: nil, raw: .none)
    }
    
    func childBlock() -> any DescriptionBlockProtocol {
        switch value {
        case .string(let string):
            fatalError("encountered `String`")
        case .block(let descriptionBlockProtocol):
            descriptionBlockProtocol
        case .customStringConvertible(let customStringConvertible):
            fatalError("encountered `customStringConvertible`")
        case .customDetailedStringConvertible(let customDetailedStringConvertible):
            customDetailedStringConvertible.descriptionBlocks()
        case .none:
            fatalError("encountered `none`")
        }
    }
    
}
