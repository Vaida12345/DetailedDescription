//
//  Configuration.swift
//  
//
//  Created by Vaida on 7/12/24.
//


public struct _Configuration {
    
    var showType: Bool?
    
    func mergingKeepingLeft(_ rhs: _Configuration) -> _Configuration {
        _Configuration(
            showType: self.showType ?? rhs.showType
        )
    }
    
    init(showType: Bool? = nil) {
        self.showType = showType
    }
    
}
