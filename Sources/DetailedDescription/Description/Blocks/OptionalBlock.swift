//
//  _OptionalBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


struct OptionalBlock: DescriptionBlockProtocol {
    
    let block: (any DescriptionBlockProtocol)?
    
    var _detachedChildren: [any DescriptionBlockProtocol]? {
        self.block?._detachedChildren
    }
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        parent: _ParentInfo = [],
        environment: _EnvironmentValues
    ) where Target : TextOutputStream {
        assert(block != nil)
        block!._detailedWrite(to: &target, trivia: trivia, parent: parent, environment: environment) // pass through
    }
    
    func _isEmpty(environment: _EnvironmentValues) -> Bool {
        self.block?._isEmpty(environment: environment) ?? true
    }
    
}
