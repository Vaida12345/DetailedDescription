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
    
    func _detailedWrite<Target>(to target: inout Target, trivia: [_Trivia]) where Target : TextOutputStream {
        if !(self.isEmpty) {
            block._detailedWrite(to: &target, trivia: trivia)
        }
    }
    
    var isEmpty: Bool {
        self.block.isEmpty
    }
    
}
