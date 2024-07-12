//
//  ConditionBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


struct ConditionBlock<TrueBlock>: DescriptionBlockProtocol where TrueBlock: DescriptionBlockProtocol {
    
    let block: TrueBlock
    
    
    func _detailedWrite<Target>(to target: inout Target, trivia: [_Trivia]) where Target : TextOutputStream {
        block._detailedWrite(to: &target, trivia: trivia)
    }
    
}
