//
//  EnvironmentValues.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-05-15.
//

public struct _EnvironmentValues {
    
    var contents: [EnvironmentKey : Any]
    
    
    func mergePreservingRight(_ rhs: _EnvironmentValues) -> _EnvironmentValues {
        _EnvironmentValues(self.contents.merging(rhs.contents, uniquingKeysWith: { $1 }))
    }
    
    
    init(_ contents: [EnvironmentKey : Any] = [:]) {
        self.contents = contents
    }
    
}

extension DescriptionBlockProtocol {
    
    func environment(_ key: EnvironmentKey, value: Any) -> any DescriptionBlockProtocol {
        ModifiedBlock(block: self, environment: _EnvironmentValues([key : value]))
    }
    
}
