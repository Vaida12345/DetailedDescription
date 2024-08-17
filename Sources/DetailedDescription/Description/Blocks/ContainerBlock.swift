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
    
    let configuration: _Configuration
    
    
    func _detailedWrite<Target>(
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
