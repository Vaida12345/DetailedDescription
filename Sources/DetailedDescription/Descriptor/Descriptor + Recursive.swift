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
    ) -> DetailedDescription.Description {
        guard let child = base[keyPath: keyPath] else { return DetailedDescription.Description() }
        
        print(">>>>")
        
        print(child)
        
        var description = DetailedDescription.Description()
        description.add(descriptionOf: child, indicator: "\(title ?? keyPath.trailingPath)", trivia: [], isLast: true)
        
        print(description)
        
        print("<<<<")
        
        return description
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
