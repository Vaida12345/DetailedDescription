//
//  main.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-07-17.
//

import DetailedDescription

private struct Model: DetailedStringConvertible {
    
    private let ahdsuaidsads: String
    
    init(string: String) {
        self.ahdsuaidsads = string
    }
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<Model>) -> any DescriptionBlockProtocol {
        descriptor.container {
            descriptor.value(for: \.ahdsuaidsads)
        }
    }
}
debugPrint(Model(string: "1234"))
