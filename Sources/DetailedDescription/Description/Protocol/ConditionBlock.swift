//
//  ConditionBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


struct ConditionBlock: DescriptionBlockProtocol {
    
    let block: any DescriptionBlockProtocol
    
    
    func _detailedWrite<Target>(to target: inout Target, trivia: [_Trivia]) where Target : TextOutputStream {
        block._detailedWrite(to: &target, trivia: trivia)
    }
    
}
