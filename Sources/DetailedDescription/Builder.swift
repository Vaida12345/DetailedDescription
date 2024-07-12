//
//  Builder.swift
//  
//
//  Created by Vaida on 7/11/24.
//


extension DetailedDescription {
    
    /// Builder for DSL.
    @resultBuilder
    public enum Builder {
        
        public static func buildBlock<each T>(_ components: repeat each T) -> _LinesBlock<repeat each T> where repeat each T: DescriptionBlockProtocol {
            _LinesBlock(lines: (repeat each components))
        }
        
//        public static func buildBlock() -> some DescriptionBlockProtocol {
//            EmptyBlock()
//        }
        
        public static func buildExpression<T>(_ expression: T) -> T where T: DescriptionBlockProtocol {
            expression
        }
        
//        public static func buildEither<TrueBlock>(first component: TrueBlock) -> some DescriptionBlockProtocol where TrueBlock: DescriptionBlockProtocol {
//            ConditionBlock(block: component)
//        }
//        
//        public static func buildEither<TrueBlock>(last component: TrueBlock) -> some DescriptionBlockProtocol where TrueBlock: DescriptionBlockProtocol {
//            ConditionBlock(block: component)
//        }
//        
//        public static func buildOptional<T>(_ component: T?) -> some DescriptionBlockProtocol where T: DescriptionBlockProtocol {
//            OptionalBlock(block: component)
//        }
        
    }
    
}
