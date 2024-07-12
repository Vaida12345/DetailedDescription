//
//  Descriptor + Optional.swift
//  
//
//  Created by Vaida on 7/12/24.
//


extension DetailedDescription.Descriptor {
    
    public func value<T>(
        _ title: String? = nil,
        for keyPath: KeyPath<Base, Optional<T>>
    ) -> DetailedDescription.Description {
        var description = DetailedDescription.Description()
        guard let attribute = base[keyPath: keyPath] else { return description }
        
        description.add(key: (title, keyPath), string: "\(attribute)")
        return description
    }
    
}
