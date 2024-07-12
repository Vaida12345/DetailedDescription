//
//  Descriptor + Recursive.swift
//  
//
//  Created by Vaida on 7/12/24.
//


extension DetailedDescription.Descriptor {
    
    public func value(
        _ title: String? = nil,
        for keyPath: KeyPath<Base, Optional<Base>>
    ) -> some DescriptionBlockProtocol {
        let title = title ?? keyPath.trailingPath
        if let child = base[keyPath: keyPath] {
            let descriptor = DetailedDescription.Descriptor<Base>(base: child)
            let description = child.detailedDescription(using: descriptor)
            
            return LineBlock(title: title, value: description)
        }
        
        return LineBlock.empty
    }
    
//    public func array(
//        _ title: String? = nil,
//        for keyPath: KeyPath<Base, Array<Base>>
//    ) -> some DescriptionBlockProtocol {
//        let children = base[keyPath: keyPath]
//        guard !children._isEmpty else { return DetailedDescription.Description() }
//        
//        return child.detailedDescription(using: DetailedDescription.Descriptor(base: child))
//    }
    
}
