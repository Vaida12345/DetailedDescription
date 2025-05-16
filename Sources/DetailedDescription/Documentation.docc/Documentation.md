# ``DetailedDescription``

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
    .package(url: "https://www.github.com/Vaida12345/DetailedDescription", from: "2.0.2")
]
```
and then adding the appropriate module to your target dependencies.

### Using Xcode Package support

You can add this framework as a dependency to your Xcode project by clicking File -> Swift Packages -> Add Package Dependency. The package is located at:
```
https://www.github.com/Vaida12345/DetailedDescription
```

## Topics

### Interface

- ``DetailedStringConvertible``
- ``DetailedStringConvertibleWithConfiguration``

### Block Structure
Use these methods and modifiers to build the resulting blocks.

- <doc:BuildMethods>
- <doc:BlockModifiers>


### Description
Use the following to retrieve the detailed description.
- ``DetailedStringConvertible/detailedDescription``
- ``detailedPrint(_:terminator:)``
- ``detailedPrint(_:configuration:terminator:)``


### Implementation Details
- ``DetailedDescription``
- ``DescriptionBlockProtocol``
- ``Initializable``
- ``CustomDetailedStringConvertible``
