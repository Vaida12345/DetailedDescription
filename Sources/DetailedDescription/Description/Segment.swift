//
//  Segment.swift
//  
//
//  Created by Vaida on 7/11/24.
//


extension DetailedDescription.Description {
    
    /// A headless segment.
    public struct Segment {
        
        let key: String
        
        let value: Value
        
        
        enum Value {
            case string(String)
            /// Opens a new hierarchy.
            case block(DetailedDescription.Description)
        }
        
        struct BuildResult {
            
            let leadingTrivia: [Trivia]
            
            let segment: Segment
            
        }
        
    }
    
}
