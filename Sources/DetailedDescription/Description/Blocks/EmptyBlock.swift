//
//  EmptyBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//

struct EmptyBlock: DescriptionBlockProtocol {
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        parent: _ParentInfo = [],
        environment: _EnvironmentValues
    ) where Target : TextOutputStream {
        fatalError("Should never call")
    }
    
    func _isEmpty(environment: _EnvironmentValues) -> Bool {
        true
    }
    
}
