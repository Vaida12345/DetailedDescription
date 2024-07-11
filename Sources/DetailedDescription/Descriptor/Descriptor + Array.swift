//
//  Descriptor + Array.swift
//  
//
//  Created by Vaida on 7/12/24.
//


extension DetailedDescription.Descriptor {
    
//    public func array<T>(
//        _ title: String? = nil,
//        for keyPath: KeyPath<Base, Array<T>>,
//        includeIndex: Bool = true
//    ) -> DetailedDescription.Description {
//        
//        var array = base[keyPath: keyPath]
//        guard !array.isEmpty else {
//            return self.value("\(title ?? keyPath.trailingPath): []")
//        }
//        
//        var description = DetailedDescription.Description()
//        
//        description.add(trivia: [], content: title ?? keyPath.trailingPath)
//        
//        let lastBlock = array.removeLast()
//        
//        for block in array {
//            description.add(descriptionOf: block, trivia: [.])
//        }
//        
//        description.add(block: lastBlock, isLast: true)
//        
//        return description
//        
//    }
    
}
