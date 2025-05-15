//
//  ContainerBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//

import Foundation


struct ContainerBlock: DescriptionBlockProtocol {
    
    let title: String?
    
    let lines: any DescriptionBlockProtocol
    
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        parent: _ParentInfo = [],
        environment: _EnvironmentValues
    ) where Target : TextOutputStream {
        if let title {
            target.write(title)
        }
        
        guard !lines._isEmpty(environment: environment) else { return }
        
        target.write("\n")
        
        lines._detailedWrite(
            to: &target,
            trivia: trivia,
            parent: .isContainer,
            environment: environment
        )
    }
    
    func _isEmpty(environment: _EnvironmentValues) -> Bool {
        false
    }
    
}
