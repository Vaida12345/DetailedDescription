//
//  EmptyBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//

struct EmptyBlock: DescriptionBlockProtocol {
    
    func _detailedWrite<Target>(to target: inout Target, trivia: [_Trivia]) where Target : TextOutputStream {
        fatalError("Should never call")
    }
    
    var _isEmpty: Bool {
        true
    }
    
}
