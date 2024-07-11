//
//  Builder.swift
//  
//
//  Created by Vaida on 7/11/24.
//


extension DetailedDescription {
    
    @resultBuilder
    public enum Builder {
        
        public static func buildBlock(_ components: Description...) -> [Description] {
            components
        }
        
        public static func buildArray(_ components: [Description]) -> [Description] {
            components
        }
        
    }
    
}
