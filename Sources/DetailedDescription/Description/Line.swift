//
//  Line.swift
//  
//
//  Created by Vaida on 7/11/24.
//


extension DetailedDescription.Description {
    
    struct Line {
        
        var leadingTrivia: [Trivia]
        
        var indicator: String
        
        var content: String
        
        
        var string: String {
            var source = self.leadingTrivia.map(\.symbol).reduce(into: "", { $0.append($1) })
            switch (!indicator.isEmpty, !content.isEmpty) {
            case (false, false):
                return source
            case (true, false):
                return source + indicator
            case (false, true):
                return source + content
            case (true, true):
                return source + indicator + ": " + content
            }
        }
        
    }
    
}
