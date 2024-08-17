//
//  ContainerBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//

import Foundation


public struct ContainerBlock<T>: DescriptionBlockProtocol where T: DescriptionBlockProtocol {
    
    let title: String?
    
    let lines: T
    
    let configuration: _Configuration
    
    
    public func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        configuration: _Configuration,
        parent: _ParentInfo = []
    ) where Target : TextOutputStream {
        if let title {
            target.write(title)
        }
        
        guard !lines._isEmpty else { return }
        
        target.write("\n")
        
        lines._detailedWrite(to: &target, trivia: trivia, configuration: self.configuration.mergingKeepingLeft(configuration), parent: .isContainer)
    }
    
}
