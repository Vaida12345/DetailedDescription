
# Methods

The methods to construct building blocks.

## Overview

Uses these methods of ``DetailedDescription/Descriptor`` to build ``DescriptionBlockProtocol``, the return value required for ``DetailedDescription/Builder``.

```swift
struct BasicModel: CustomDetailedStringConvertible {

    let name: String

    let age: Int

    func detailedDescription(using descriptor: DetailedDescription.Descriptor<BasicModel>) -> any DescriptionBlockProtocol {
        descriptor.value(for: \.name) // `value` is a methods of `descriptor`.
    }
}
```

## Topics

### Descriptor
The structure providing the methods.

- ``DetailedDescription/Descriptor``

### Container
- ``DetailedDescription/Descriptor/container(_:blocks:)``

### Describing Value
- ``DetailedDescription/Descriptor/value(_:for:)``
- ``DetailedDescription/Descriptor/value(_:of:)``
- ``DetailedDescription/Descriptor/constant(_:)``

### Describing Optional
- ``DetailedDescription/Descriptor/optional(_:for:)``
- ``DetailedDescription/Descriptor/optional(_:of:)``

### Describing Sequences
- ``DetailedDescription/Descriptor/sequence(_:for:)``
- ``DetailedDescription/Descriptor/sequence(_:of:)``

### ForEach
- ``DetailedDescription/Descriptor/forEach(_:blocks:)``
