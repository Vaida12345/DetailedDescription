//
//  DetailedDescriptionTests.swift
//
//
//  Created by Vaida on 7/12/24.
//

import Foundation
import Testing
@testable 
import DetailedDescription

struct Model: DetailedStringConvertible {
    
    let name: String
    
    let age: Int
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<Model>) -> any DescriptionBlockProtocol {
        descriptor.container("Model<T>") {
            descriptor.container("details") {
                descriptor.value(for: \.name)
                descriptor.value("age", of: age)
            }
            
            descriptor.constant("the end")
        }
    }
}

struct BasicModel: DetailedStringConvertible {
    
    let name: String
    
    let age: Int
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<BasicModel>) -> any DescriptionBlockProtocol {
        descriptor.container("BasicModelModel<T>") {
            descriptor.value(for: \.name)
            descriptor.value(for: \.age)
        }
    }
    
}

struct EmptyModel: DetailedStringConvertible {
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<EmptyModel>) -> any DescriptionBlockProtocol {
        descriptor.container("Model<T>") {
            
        }
    }
}

nonisolated(unsafe) let descriptor = DetailedDescription.Descriptor(base: EmptyModel())

@Test func testBasic() async throws {
    let model = BasicModel(name: "hello", age: 100)
    let match = """
    BasicModelModel<T>
     ├─name: "hello"
     ╰─age: 100
    """
    #expect(model.detailedDescription == match)
}


/// Redirects the standard output and captures the result.
public func withStandardOutputCaptured(_ body: () throws -> Void) throws -> FileHandle {
    // Create a pipe and redirect stdout
    let pipe = Pipe()
    let oldStdout = dup(STDOUT_FILENO)
    dup2(pipe.fileHandleForWriting.fileDescriptor, STDOUT_FILENO)
    
    // Print something (this will be captured)
    try body()
    
    // Restore stdout
    dup2(oldStdout, STDOUT_FILENO)
    close(oldStdout)
    try pipe.fileHandleForWriting.close()
    
    return pipe.fileHandleForReading
}


@Test func testNested() throws {
    let model = Model(name: "hello", age: 100)
    let match = """
    Model<T>
     ├─details
     │ ├─name: "hello"
     │ ╰─age: 100
     ╰─the end
    """
    
    #expect(model.detailedDescription == match)
    
    let data = try withStandardOutputCaptured {
        detailedPrint(model, terminator: "")
    }.readToEnd()!
    let output = String(data: data, encoding: .utf8) ?? "(false data)"
    
    #expect(output == match)
}

@Test func testNestedDebugDescription() throws {
    let model = Model(name: "hello", age: 100)
    let match = """
    Model<T>
     ├─details
     │ ├─name: "hello"
     │ ╰─age: 100
     ╰─the end
    """
    
    #expect(model.detailedDescription == match)
    
    let data = try withStandardOutputCaptured {
        debugPrint(model, terminator: "")
    }.readToEnd()!
    let output = String(data: data, encoding: .utf8) ?? "(false data)"
    
    #expect(output == match)
}

@Test func testNestedMirror() throws {
    let model = Model(name: "hello", age: 100)
    let match = """
    Model<T>
     ├─details
     │ ├─name: "hello"
     │ ╰─age: 100
     ╰─the end
    """
    
    #expect(model.detailedDescription == match)
    
    let output = String(reflecting: model)
    
    #expect(output == match)
}

@Test func testEmpty() {
    let model = EmptyModel()
    
    #expect(model.detailedDescription == "Model<T>")
}

@Test func testLongString() {
    let model = BasicModel(name: """
    I
    Am
    Long
    String
    """, age: 100)
    let match = #"""
    BasicModelModel<T>
     ├─name: """
     │       I
     │       Am
     │       Long
     │       String
     │       """
     ╰─age: 100
    """#
    #expect(model.detailedDescription == match)
}
