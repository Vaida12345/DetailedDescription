//
//  LineBlock.swift
//  
//
//  Created by Vaida on 7/12/24.
//


struct LineBlock: DescriptionBlockProtocol {
    
    let label: String?
    
    let value: Value
    
    let type: String
    
    init<T>(label: String?, value: T) {
        self.label = label
        self.type = "\(Swift.type(of: value as Any))"
        
        if let value = value as? (any DescriptionBlockProtocol) {
            self.value = .block(value)
        } else if let value = value as? (any DetailedStringConvertibleWithConfiguration) {
            self.value = .configurable(value)
        } else if let value = value as? (any DetailedStringConvertible) {
            self.value = .detailedString(value)
        } else if let value = value as? String {
            self.value = .string(value, isString: true)
        } else if let value = value as? CustomStringConvertible {
            self.value = .customStringConvertible(value)
        } else {
            self.value = .string("\(value)", isString: false)
        }
    }
    
    init(label: String?, raw: Value) {
        self.type = ""
        self.label = label
        self.value = raw
    }
    
    var _detachedChildren: [any DescriptionBlockProtocol]? {
        nil
    }
    
    func _detailedWrite<Target>(
        to target: inout Target,
        trivia: [_Trivia],
        parent: _ParentInfo = [],
        environment: _EnvironmentValues
    ) where Target : TextOutputStream {
        var leadingCount = 0
        if let label {
            target.write(label)
            leadingCount += label.count
            if !label.isEmpty {
                target.write(": ")
                leadingCount += 2
            }
        }
        
        switch value {
        case .string(let string, let isString):
            if string.contains("\n") {
                if isString {
                    target.write(#"""""#)
                }
                if environment.showType {
                    target.write(" <String>")
                }
                target.write("\n")
                for line in string.components(separatedBy: .newlines) {
                    target.write(trivia.map(\.symbol).joined())
                    target.write(String(repeating: " ", count: leadingCount))
                    target.write(line)
                    target.write("\n")
                }
                target.write(trivia.map(\.symbol).joined())
                target.write(String(repeating: " ", count: leadingCount))
                if isString {
                    target.write(#"""""#)
                }
            } else {
                if isString {
                    target.write("\"")
                }
                target.write(string)
                if isString {
                    target.write("\"")
                }
                if environment.showType {
                    target.write(" <\(type)>")
                }
            }
        case .block(let block):
            block._detailedWrite(to: &target, trivia: trivia, parent: [], environment: environment)
        case .detailedString(let descriptor):
            descriptor.descriptionBlocks()
                ._detailedWrite(to: &target, trivia: trivia, parent: [], environment: environment)
        case .customStringConvertible(let value):
            target.write(value.description)
            if environment.showType {
                target.write(" <\(type)>")
            }
        case .configurable(let descriptor):
            handle(configurable: descriptor, environment: environment)
                ._detailedWrite(to: &target, trivia: trivia, parent: [], environment: environment)
        }
    }
    
    enum Value {
        case string(String, isString: Bool)
        case block(any DescriptionBlockProtocol)
        case customStringConvertible(any CustomStringConvertible)
        case configurable(any DetailedStringConvertibleWithConfiguration)
        case detailedString(any DetailedStringConvertible)
    }
    
    func handle<T: DetailedStringConvertibleWithConfiguration>(configurable: T, environment: _EnvironmentValues) -> any DescriptionBlockProtocol {
        let configurationType = T.DescriptionConfiguration.self
        let configuration = environment.configuration(for: configurationType)
        
        return configurable.descriptionBlocks(configuration: configuration)
    }
    
    
    func _isEmpty(environment: _EnvironmentValues) -> Bool {
        switch value {
        case let .block(block):
            block._isEmpty(environment: environment)
        case .configurable(let descriptor):
            handle(configurable: descriptor, environment: environment)._isEmpty(environment: environment)
        case .detailedString(let descriptor):
            descriptor.descriptionBlocks()._isEmpty(environment: environment)
        default:
            false
        }
    }
    
}
