//
//  DSLTests.swift
//  DetailedDescription
//
//  Created by Vaida on 8/17/24.
//

import Testing
@testable
import DetailedDescription


struct LoopModel: CustomDetailedStringConvertible {
    
    let dictionary: [String : String]
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<LoopModel>) -> some DescriptionBlockProtocol {
        descriptor.container {
            if 1 == 0 {
                descriptor.value("", of: "2")
            } else if 2 == 1 {
                //                    if dictionary.count == 0 {
                //                        descriptor.value("", of: "2")
                //                    } else {
                //                        descriptor.value("", of: "1")
                //                    }
            } else {
                
            }
        }
    }
}


@Test func testLoopModel() async throws {
    let model = LoopModel(dictionary: ["a" : "1"])
    let match = """
    LoopModel
     ╰─d
    """
    
    #expect(model.detailedDescription == match)
}

//return descriptor.container("CGPDFArray") {
//    descriptor.forEach(0..<count) { index in
//        if let innerArray = source._arrayGetValue(using: CGPDFArrayGetArray, index: index) {
//            descriptor.value("", of: CGPDFArrayWrapper(source: innerArray))
//        } else if let name = source._arrayGetValue(using: CGPDFArrayGetName, index: index) {
//            descriptor.value("", of: String(cString: name))
//        } else if let stream = source._arrayGetValue(using: CGPDFArrayGetStream, index: index) {
//            descriptor.value("", of: stream.dictionary)
//        } else if let dictionary = source._arrayGetValue(using: CGPDFArrayGetDictionary, index: index) {
//            descriptor.value("", of: dictionary)
//        } else if let string = source._arrayGetValue(using: CGPDFArrayGetString, index: index) {
//            if let value = CGPDFStringCopyDate(string) {
//                descriptor.value("", of: value)
//            } else {
//                let value = CGPDFStringCopyTextString(string)
//                descriptor.value("", of: value)
//            }
//        } else if let object = source._arrayGetValue(using: CGPDFArrayGetObject, index: index) {
//            descriptor.value("", of: CGPDFObjectWrapper(key: "", source: object))
//        } else {
//            descriptor.string("(unknown)")
//        }
//    }
//    }
