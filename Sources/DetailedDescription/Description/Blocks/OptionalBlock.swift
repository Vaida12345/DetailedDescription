//
//  _OptionalBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


struct OptionalBlock: DescriptionBlockProtocol {
    
    let block: (any DescriptionBlockProtocol)?
    
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        configuration: _Configuration,
        parent: _ParentInfo = []
    ) where Target : TextOutputStream {
        assert(block != nil)
        block!._detailedWrite(to: &target, trivia: trivia, configuration: configuration, parent: parent) // pass through
    }
    
    public var _isEmpty: Bool {
        self.block?._isEmpty ?? true
    }
    
}
