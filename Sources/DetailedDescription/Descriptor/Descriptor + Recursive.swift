//
//  Descriptor + Recursive.swift
//  
//
//  Created by Vaida on 7/12/24.
//


//extension DetailedDescription.Descriptor {
//    
//    public func value(
//        _ title: String? = nil,
//        for keyPath: KeyPath<Base, Optional<Base>>
//    ) -> some DescriptionBlockProtocol {
//        let title = title ?? keyPath.trailingPath
//        if let child = base[keyPath: keyPath] {
//            let descriptor = DetailedDescription.Descriptor<Base>(base: child)
//            let description = child.detailedDescription(using: descriptor)
//            
//            return LineBlock(title: title, value: description)
//        }
//        
//        return LineBlock.empty
//    }
//    
//    public func array(
//        _ title: String? = nil,
//        for keyPath: KeyPath<Base, Array<Base>>,
//        includeIndex: Bool = true
//    ) -> some DescriptionBlockProtocol {
//        let title = title ?? keyPath.trailingPath
//        
//        let array = base[keyPath: keyPath]
//        
//        return LineBlock(
//            title: title,
//            value: ArrayBlock(
//                blocks: array.map {
//                    LineBlock(title: nil, value: $0)
//                },
//                includeIndex: includeIndex)
//            )
//    }
//    
//}
