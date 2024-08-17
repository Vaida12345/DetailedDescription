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
        
        public static func buildBlock<each T>(_ components: repeat each T) -> LinesBlock<repeat each T> where repeat each T: DescriptionBlockProtocol {
            LinesBlock(lines: (repeat each components))
        }
        
        public static func buildBlock() -> EmptyBlock {
            EmptyBlock()
        }
        
        public static func buildEither<TrueBlock, FalseBlock>(first component: TrueBlock) -> EitherBlock<TrueBlock, FalseBlock> where TrueBlock: DescriptionBlockProtocol, FalseBlock: DescriptionBlockProtocol {
            EitherBlock(block: component)
        }
        
        public static func buildEither<TrueBlock, FalseBlock>(second component: TrueBlock) -> EitherBlock<TrueBlock, FalseBlock> where TrueBlock: DescriptionBlockProtocol, FalseBlock: DescriptionBlockProtocol {
            EitherBlock(block: component)
        }
        
        public static func buildOptional<T>(_ component: T?) -> OptionalBlock<T> where T: DescriptionBlockProtocol {
            OptionalBlock(block: component)
        }
        
        public static func buildArray<T>(_ components: [T]) -> FlattenLinesBlock<T> where T: DescriptionBlockProtocol {
            FlattenLinesBlock<T>(lines: components)
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
