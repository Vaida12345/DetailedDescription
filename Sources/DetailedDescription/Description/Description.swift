//
//  Description.swift
//  
//
//  Created by Vaida on 7/11/24.
//


extension DetailedDescription {
    
    public struct Description: CustomStringConvertible {
        
        private var lines: [Line]
        
        var string: String {
            lines.map(\.string).joined(separator: "\n")
        }
        
        var isEmpty: Bool {
            self.lines.isEmpty
        }
        
        public var description: String {
            var description = "-Description\n"
            var lines = self.lines
            
            guard !lines.isEmpty else { return "<Empty Description>" }
            let lastLine = lines.removeLast()
            
            for line in lines {
                description += "├─\(line.leadingTrivia) \(line.content)\n"
            }
            
            description += "╰─\(lastLine.leadingTrivia) \(lastLine.content)"
            
            return description
        }
        
        mutating func add(trivia: [Line.Trivia], indicator: String, content: String) {
            self.lines.append(Line(leadingTrivia: trivia, indicator: indicator, content: content))
        }
        
        mutating func add<B, T>(trivia: [Line.Trivia], indicator: (String?, KeyPath<B, T>), content: String) {
            self.lines.append(Line(leadingTrivia: trivia, indicator: indicator.0 ?? indicator.1.trailingPath, content: content))
        }
        
        
        mutating func add(block: Description, isLast: Bool) {
            var lines = block.lines
            guard !lines.isEmpty else { return }
            let firstLine = lines.removeFirst()
            
            let trivia: [Line.Trivia] = isLast ? [.space, .block(.lastChild), .block(.dash)] : [.space, .block(.child), .block(.dash)]
            self.add(trivia: trivia + firstLine.leadingTrivia, indicator: firstLine.indicator, content: firstLine.content)
            
            let lineTrivia: [Line.Trivia] = isLast ? [.space, .space, .space] : [.space, .block(.vertical), .space]
            
            for line in lines {
                self.add(trivia: lineTrivia + line.leadingTrivia, indicator: line.indicator, content: line.content)
            }
        }
        
        mutating func add<Base>(descriptionOf base: Base, indicator: String, trivia: [Line.Trivia], isLast: Bool) where Base: CustomDetailedStringConvertible {
            var description = base.detailedDescription(using: DetailedDescription.Descriptor<Base>(base: base))
            guard !description.lines.isEmpty else { return }
            assert(description.lines[0].indicator.isEmpty)
            description.lines[0].indicator = indicator
            
            self.add(block: description, isLast: isLast)
        }
        
//        mutating func add(descriptionOf base: Any, trivia: [Line.Trivia]) {
//            self.lines.append(Line(leadingTrivia: trivia, content: "\(base)"))
//        }
        
        
        init() {
            self.lines = []
        }
        
    }
    
}
