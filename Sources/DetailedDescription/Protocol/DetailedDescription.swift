//
//  DetailedDescription.swift
//  
//
//  Created by Vaida on 7/11/24.
//


/// The container for DetailedDescription.
public enum DetailedDescription {
    
}


/// Prints the detailed description.
public func detailedPrint(_ content: some CustomDetailedStringConvertible, terminator: String = "\n") {
    print(content.detailedDescription, terminator: terminator)
}
