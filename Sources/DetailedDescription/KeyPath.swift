//
//  KeyPath.swift
//  
//
//  Created by Vaida on 7/11/24.
//


extension KeyPath {
    
    var trailingPath: String {
        let path = "\(self)"
        return String(path[path.index(after: path.lastIndex(of: ".")!)...])
    }
    
}
