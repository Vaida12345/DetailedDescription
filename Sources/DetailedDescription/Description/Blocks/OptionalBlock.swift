//
//  _OptionalBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


struct OptionalBlock<T>: DescriptionBlockProtocol where T: DescriptionBlockProtocol {
    
    let block: T?
    
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        configuration: _Configuration,
        parent: _ParentInfo = []
    ) where Target : TextOutputStream {
        if let block {
            block._detailedWrite(to: &target, trivia: trivia, configuration: configuration)
        }
    }
    
    var _isEmpty: Bool {
        self.block?._isEmpty ?? true
    }
    
}
