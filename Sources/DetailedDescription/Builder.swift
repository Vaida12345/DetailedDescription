//
//  Builder.swift
//  
//
//  Created by Vaida on 7/11/24.
//


extension DetailedDescription {
    
    @resultBuilder
    public enum Builder {
        
        public static func buildBlock(_ components: (any DescriptionBlockProtocol)...) -> LinesBlock {
            LinesBlock(lines: components)
        }
        
        public static func buildBlock() -> some DescriptionBlockProtocol {
            EmptyBlock()
        }
        
        public static func buildEither<TrueBlock>(first component: TrueBlock) -> some DescriptionBlockProtocol where TrueBlock: DescriptionBlockProtocol {
            ConditionBlock(block: component)
        }
        
        public static func buildEither<TrueBlock>(last component: TrueBlock) -> some DescriptionBlockProtocol where TrueBlock: DescriptionBlockProtocol {
            ConditionBlock(block: component)
        }
        
        public static func buildOptional<T>(_ component: T?) -> some DescriptionBlockProtocol where T: DescriptionBlockProtocol {
            OptionalBlock(block: component)
        }
        
    }
    
}
