A package to provide detailed description of any structure.

## Overview

``DetailedStringConvertible`` serves as an alternative to `Mirror`. This protocol describes the details to types confirming to ``DetailedStringConvertible`` without exposing implementation details of Swift Foundation structures that `Mirror` would.

To use this package, your structure needs to conform to the ``DetailedStringConvertible`` protocol.

```swift
struct BasicModel: DetailedStringConvertible {

    let name: String

    let age: Int

    func detailedDescription(
        using descriptor: DetailedDescription.Descriptor<BasicModel>
    ) -> any DescriptionBlockProtocol {
        descriptor.container {
            descriptor.value(for: \.name)
            descriptor.value(for: \.age)
        }
    }
}

let model = BasicModel(name: "hello", age: 100)

detailedPrint(model)
// BasicModel
//  ├─name: "hello"
//  ╰─age: 100
```

## Getting Started

`DetailedDescription` uses [Swift Package Manager](https://www.swift.org/documentation/package-manager/) as its build tool. If you want to import in your own project, it's as simple as adding a `dependencies` clause to your `Package.swift`:
```swift
dependencies: [
    .package(url: "https://www.github.com/Vaida12345/DetailedDescription", from: "2.0.3")
]
```
and then adding the appropriate module to your target dependencies.

### Using Xcode Package support

You can add this framework as a dependency to your Xcode project by clicking File -> Swift Packages -> Add Package Dependency. The package is located at:
```
https://www.github.com/Vaida12345/DetailedDescription
```

## Documentation

Full Documentation in DocC. [View on Github Pages](https://vaida12345.github.io/DetailedDescription/documentation/detaileddescription)

## More Examples

### Recursive

Arguably the best use case is when dealing with recursive structures.

| Definition | Result |
| ---------- | ------ |
| <pre lang="swift">struct SCNNodeDescriptor: DetailedStringConvertible {&#13;    &#13;    let node: SCNNode&#13;    &#13;    func detailedDescription(&#13;        using descriptor: DetailedDescription.Descriptor<SCNNodeDescriptor>&#13;    ) -> any DescriptionBlockProtocol {&#13;        descriptor.container {&#13;            descriptor.value("name", of: node.name)&#13;            descriptor.sequence("children", &#13;                       of: node.childNodes.map(SCNNodeDescriptor.init)&#13;            )&#13;        }&#13;    }&#13;    &#13;}</pre> | <pre>SCNNodeDescriptor&#13; ├─name: nil&#13; ╰─children: <1 element>&#13;   ╰─[0]: SCNNodeDescriptor&#13;          ├─name: "scene"&#13;          ╰─children: <1 element>&#13;            ╰─[0]: SCNNodeDescriptor&#13;                   ├─name: "Meshes"&#13;                   ╰─children: ...</pre> |

With the above definition, you can now inspect a complex `SCNNode` by `detailedPrint(SCNNodeDescriptor(node: node))`.

### DSL

Similar to `SwiftUI`, the `detailedDescription` function also supports building conditional blocks, and the use of loops.

```swift
func detailedDescription(
    using descriptor: DetailedDescription.Descriptor<Component>
) -> any DescriptionBlockProtocol {
    descriptor.container {
        if !content.isEmpty {
            descriptor.value(for: \.content)
        }
        descriptor.sequence(for: \.metadata)
            .hideEmptySequence()
        descriptor.value(for: \.boundary)
    }
}
```
In the above example, the existence of `content` in its output is conditional, and appears only when it is not empty.

<br>

It also supports complex block-building. The following is a portion of code for exploring the PDF structure using `PDFKit`

```swift
descriptor.container("CGPDFArray") {
    descriptor.forEach(0..<count) { index in
        if let innerArray = source._arrayGetValue(using: CGPDFArrayGetArray, index: index) {
            descriptor.value("", of: CGPDFArrayWrapper(source: innerArray))
        } else if let name = source._arrayGetValue(using: CGPDFArrayGetName, index: index) {
            descriptor.value("", of: String(cString: name))
        } else if let stream = source._arrayGetValue(using: CGPDFArrayGetStream, index: index) {
            descriptor.value("", of: stream.dictionary)
        } else if let dictionary = source._arrayGetValue(using: CGPDFArrayGetDictionary, index: index) {
            descriptor.value("", of: dictionary)
        } else {
            descriptor.string("(unknown)")
        }
    }
 }
```

## Showing Types

The [`container`](https://vaida12345.github.io/DetailedDescription/documentation/detaileddescription/detaileddescription/descriptor/container(_:showtype:blocks:)) comes with ways to configure how you want to describe the children, including `showType`.

```swift
struct BasicModel: DetailedStringConvertible {
    
    let name: String
    
    let age: Int
    
    func detailedDescription(
        using descriptor: DetailedDescription.Descriptor<BasicModel>
    ) -> any DescriptionBlockProtocol {
        descriptor.container {
            descriptor.container("details") {
                descriptor.value(for: \.name)
                descriptor.value(for: \.age)
            }
            .showType(false)
            
            descriptor.value(for: \.name)
        }
        .showType()
    }
}
```

Similar to `SwiftUI` environment values, values are effected by the innermost definition of `showType`, and child containers inherit parent configuration if not specified.

```swift
BasicModel
 ├─details
 │ ├─name: "dog"
 │ ╰─age: 11
 ╰─name: "dog" <String>
```


