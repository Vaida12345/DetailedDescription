//
//  DSLTests.swift
//  DetailedDescription
//
//  Created by Vaida on 8/17/24.
//

import Testing
@testable
import DetailedDescription


struct LoopModel: DetailedStringConvertible {
    
    let dictionary: [String : String]
    
    let index: Int
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<LoopModel>) -> any DescriptionBlockProtocol {
        descriptor.container {
            if index == 0 {
                descriptor.value("", of: "2")
            } else if index == 1 {
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
    let model = LoopModel(dictionary: ["a" : "1"], index: 2)
    let match = """
    LoopModel
    """
    
    #expect(model.detailedDescription == match)
}


struct MultiArray: DetailedStringConvertible {
    
    let show: Bool
    let children: [MultiArray]
    
    
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<MultiArray>) -> any DescriptionBlockProtocol {
        descriptor.container {
            if show {
                for child in children {
                    descriptor.value("", of: child)
                }
            } else {
                descriptor.constant("leaf")
            }
        }
    }
    
}


@Test func DSLRecursive() async throws {
    let model = MultiArray(show: true, children: [
        MultiArray(show: true, children: [
            MultiArray(show: false, children: [])
        ]),
        MultiArray(show: false, children: [
            MultiArray(show: false, children: [])
        ])
    ])
    
    let reference = """
    MultiArray
     ├─MultiArray
     │ ╰─MultiArray
     │   ╰─leaf
     ╰─MultiArray
       ╰─leaf
    """
    
    #expect(model.detailedDescription == reference)
}


struct ForEachMultiArray: DetailedStringConvertible {
    
    let children: [Int]
    
    
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<ForEachMultiArray>) -> any DescriptionBlockProtocol {
        descriptor.container {
            if true {
                for child in children {
                    descriptor.value("", of: child)
                }
            }
        }
    }
    
}


@Test func DSLForEach() async throws {
    let model = ForEachMultiArray(children: [1, 2, 3, 4, 5])
    let expected = """
        ForEachMultiArray
         ├─1
         ├─2
         ├─3
         ├─4
         ╰─5
        """
    #expect(model.detailedDescription == expected)
}


struct FlatModel: DetailedStringConvertible {
    
    func detailedDescription(using descriptor: DetailedDescription.Descriptor<FlatModel>) -> any DescriptionBlockProtocol {
        descriptor.container {
            if true {
                descriptor.constant("123")
            }
            descriptor.constant("456")
        }
    }
}


@Test(.disabled("Order is wrong")) func testFlatModel() async throws {
    let model = FlatModel()
    let expected = """
        FlatModel
         ├─123
         ╰─456
        """
    dump(model.descriptionBlocks())
    #expect(model.detailedDescription == expected)
}
