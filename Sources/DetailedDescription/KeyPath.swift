//
//  KeyPath.swift
//  
//
//  Created by Vaida on 7/11/24.
//


extension KeyPath {
    
    var trailingPath: String {
        let path = "\(self)"
        if let lastDot = path.lastIndex(of: ".") {
            return String(path[path.index(after: lastDot)...])
        }
        return path
    }
    
}
