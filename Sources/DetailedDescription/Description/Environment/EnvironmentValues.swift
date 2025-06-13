//
//  EnvironmentValues.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-05-15.
//

public struct _EnvironmentValues {
    
    var contents: [ObjectIdentifier : Any]
    
    
    func mergePreservingRight(_ rhs: _EnvironmentValues) -> _EnvironmentValues {
        _EnvironmentValues(self.contents.merging(rhs.contents, uniquingKeysWith: { $1 }))
    }
    
    
    init(_ contents: [ObjectIdentifier : Any] = [:]) {
        self.contents = contents
    }
    
    subscript<K: EnvironmentKey>(key: K.Type) -> K.Value {
        get {
            let id = ObjectIdentifier(key)
            if let any = contents[id] as? K.Value {
                return any
            } else {
                return K.defaultValue
            }
        }
        set {
            let id = ObjectIdentifier(key)
            contents[id] = newValue
        }
    }
    
}

extension DescriptionBlockProtocol {
    
    func environment<K: EnvironmentKey>(_ key: K.Type, value: K.Value) -> any DescriptionBlockProtocol {
        ModifiedBlock(block: self, environment: _EnvironmentValues([ObjectIdentifier(K.self) : value]))
    }
    
}
