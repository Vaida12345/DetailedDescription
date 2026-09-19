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
            
            descriptor.raw("the end")
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
///
/// - Returns: Empty string if the returned file handle is empty.
@inlinable
@available(macOS 10.15, iOS 13, watchOS 6, *)
func withStandardOutputCaptured(_ body: () throws -> Void) throws -> Data {
    fflush(stdout)
    
    let pipe = Pipe()
    let oldStdout = dup(STDOUT_FILENO)
    
    do {
        dup2(pipe.fileHandleForWriting.fileDescriptor, STDOUT_FILENO)
        
        defer {
            fflush(stdout)
            dup2(oldStdout, STDOUT_FILENO)
            close(oldStdout)
        }
        
        try body()
        fflush(stdout)
        try pipe.fileHandleForWriting.close()
    }
    
    return try pipe.fileHandleForReading.readToEnd() ?? Data()
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
    }
    let output = String(data: data, encoding: .utf8) ?? "(false data)"
    
    #expect(output == match)
}

@Suite(.serialized)
struct PrintSuite {
    
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
        }
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
