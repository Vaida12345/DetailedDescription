//
//  LinesBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


public struct _LinesBlock<each T: DescriptionBlockProtocol> {
    
    let lines: (repeat each T)
    
    
    init(lines: (repeat each T)) {
        self.lines = lines
    }
    
}
