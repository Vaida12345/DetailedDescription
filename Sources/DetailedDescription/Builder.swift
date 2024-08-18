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
        
        public static func buildBlock(_ components: (any DescriptionBlockProtocol)...) -> any DescriptionBlockProtocol {
            FlattenLinesBlock(lines: components)
        }
        
        public static func buildBlock() -> any DescriptionBlockProtocol {
            EmptyBlock()
        }
        
        public static func buildEither(first component: any DescriptionBlockProtocol) -> any DescriptionBlockProtocol {
            AnyBlock(block: component)
        }
        
        public static func buildEither(second component: any DescriptionBlockProtocol) -> any DescriptionBlockProtocol {
            AnyBlock(block: component)
        }
        
        public static func buildOptional(_ component: (any DescriptionBlockProtocol)?) -> any DescriptionBlockProtocol {
            OptionalBlock(block: component)
        }
        
        public static func buildArray(_ components: [any DescriptionBlockProtocol]) -> any DescriptionBlockProtocol {
            FlattenLinesBlock(lines: components)
        }
        
//        public static func buildPartialBlock<T>(first: T) -> T where T: DescriptionBlockProtocol  {
//            first
//        }
//        
//        public static func buildPartialBlock(accumulated: some DescriptionBlockProtocol, next: some DescriptionBlockProtocol) -> some DescriptionBlockProtocol {
//            LinesBlock(lines: (accumulated, next))
//        }
        
    }
    
}
