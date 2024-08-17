//
//  AnyBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


struct AnyBlock: DescriptionBlockProtocol {
    
    let block: any DescriptionBlockProtocol
    
    
    init(block: any DescriptionBlockProtocol) {
        self.block = block
    }
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        configuration: _Configuration,
        parent: _ParentInfo = []
    ) where Target : TextOutputStream {
        assert(!self._isEmpty)
        block._detailedWrite(to: &target, trivia: trivia, configuration: configuration, parent: parent) // pass through
    }
    
    var _isEmpty: Bool {
        self.block._isEmpty
    }
    
}
