//
//  Config + print.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-05-16.
//

/// Prints the detailed description.
public func detailedPrint<T>(_ content: T, configuration: T.DescriptionConfiguration = T.DescriptionConfiguration(), terminator: String = "\n") where T: DetailedStringConvertibleWithConfiguration {
    print(content.detailedDescription(configuration: configuration), terminator: terminator)
}
