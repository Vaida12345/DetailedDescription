A package to provide detailed description of any structure.

## Overview

``CustomDetailedStringConvertible`` serves as an alternative to `Mirror`. This protocol describes the details to types confirming to ``CustomDetailedStringConvertible`` without exposing implementation details of Swift Foundation structures that `Mirror` would.

To use this package, your structure needs to conform to the ``CustomDetailedStringConvertible`` protocol.

```swift
struct BasicModel: CustomDetailedStringConvertible {

    let name: String

    let age: Int

    func detailedDescription(using descriptor: DetailedDescription.Descriptor<BasicModel>) -> any DescriptionBlockProtocol {
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
    .package(url: "https://github.com/Vaida12345/DetailedDescription.git", branch: "main")
]
```
and then adding the appropriate module to your target dependencies.

### Using Xcode Package support

You can add this framework as a dependency to your Xcode project by clicking File -> Swift Packages -> Add Package Dependency. The package is located at:
```
https://github.com/Vaida12345/DetailedDescription
```

## Documentation

Full Documentation in DocC. [View on Github Pages](https://vaida12345.github.io/DetailedDescription/documentation/detaileddescription)
