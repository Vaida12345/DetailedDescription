//
//  EitherBlock.swift
//  DetailedDescription
//
//  Created by Vaida on 8/17/24.
//


public struct EitherBlock<TrueBlock, FalseBlock>: DescriptionBlockProtocol where TrueBlock: DescriptionBlockProtocol, FalseBlock: DescriptionBlockProtocol {
    
    let block: any DescriptionBlockProtocol
    
    
    public func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        configuration: _Configuration,
        parent: _ParentInfo = []
    ) where Target : TextOutputStream {
        block._detailedWrite(to: &target, trivia: trivia, configuration: configuration)
    }
    
    public var _isEmpty: Bool {
        block._isEmpty
    }
    
}
