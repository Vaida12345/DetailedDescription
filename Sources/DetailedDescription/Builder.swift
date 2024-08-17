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
        
        public static func buildBlock<each T>(_ components: repeat each T) -> some DescriptionBlockProtocol where repeat each T: DescriptionBlockProtocol {
            LinesBlock(lines: (repeat each components))
        }
        
        public static func buildBlock() -> some DescriptionBlockProtocol {
            EmptyBlock()
        }
        
        public static func buildExpression<T>(_ expression: T) -> T where T: DescriptionBlockProtocol {
            expression
        }
        
        public static func buildEither<T>(first component: T) -> T where T: DescriptionBlockProtocol {
            component
        }
        
        public static func buildEither<T>(second component: T) -> T where T: DescriptionBlockProtocol {
            component
        }
        
        public static func buildOptional<T>(_ component: T?) -> some DescriptionBlockProtocol where T: DescriptionBlockProtocol {
            OptionalBlock(block: component)
        }
        
        public static func buildArray<T>(_ components: [T]) -> some DescriptionBlockProtocol where T: DescriptionBlockProtocol {
            FlattenLinesBlock<T>(lines: components)
        }
        
        public static func buildPartialBlock<T>(first: T) -> T where T: DescriptionBlockProtocol  {
            first
        }
        
        public static func buildPartialBlock(accumulated: some DescriptionBlockProtocol, next: some DescriptionBlockProtocol) -> some DescriptionBlockProtocol {
            LinesBlock(lines: (accumulated, next))
        }
        
    }
    
}
