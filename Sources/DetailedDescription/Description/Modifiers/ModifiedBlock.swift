//
//  AnyBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


struct ModifiedBlock: DescriptionBlockProtocol {
    
    let block: any DescriptionBlockProtocol
    
    let environment: _EnvironmentValues
    
    
    init(block: any DescriptionBlockProtocol, environment: _EnvironmentValues = _EnvironmentValues()) {
        self.block = block
        self.environment = environment
    }
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        parent: _ParentInfo = [],
        environment: _EnvironmentValues
    ) where Target : TextOutputStream {
        assert(!self._isEmpty(environment: environment))
        block._detailedWrite(
            to: &target,
            trivia: trivia,
            parent: parent,
            environment: environment.mergePreservingRight(self.environment)
        ) // pass through
    }
    
    func _isEmpty(environment: _EnvironmentValues) -> Bool {
        self.block._isEmpty(environment: environment)
    }
    
}
