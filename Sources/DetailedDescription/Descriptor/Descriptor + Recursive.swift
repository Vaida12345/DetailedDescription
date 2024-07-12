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
    ) -> any DescriptionBlockProtocol {
        if let child = base[keyPath: keyPath] {
            return self.container(title ?? keyPath.trailingPath) {
                child.detailedDescription(using: DetailedDescription.Descriptor<Base>(base: child))
            }
        }
        
        return EmptyBlock()
    }
    
//    public func array(
//        _ title: String? = nil,
//        for keyPath: KeyPath<Base, Array<Base>>
//    ) -> DetailedDescription.Description {
//        let children = base[keyPath: keyPath]
//        guard !children.isEmpty else { return DetailedDescription.Description() }
//        
//        return child.detailedDescription(using: DetailedDescription.Descriptor(base: child))
//    }
    
}
