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
        self.value = .string("\(value)")
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
        }
    }
    
    enum Value {
        case string(String)
    }
    
}
