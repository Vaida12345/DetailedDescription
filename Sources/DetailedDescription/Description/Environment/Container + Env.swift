//
//  Container + Env.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-05-15.
//

private extension EnvironmentKey {
    static let showType = EnvironmentKey(high: 2, low: 1)
}


extension _EnvironmentValues {
    
    var showType: Bool {
        contents[.showType] as? Bool ?? false
    }
    
}


public extension DescriptionBlockProtocol {
    
    /// Specifies that the type information should also be exposed.
    ///
    /// The `showType` modifier can be used to specify whether the blocks should show their types.
    ///
    /// ```swift
    /// descriptor.container {
    ///     descriptor.container("details") {
    ///         descriptor.value(for: \.name)
    ///         descriptor.value(for: \.age)
    ///     }
    ///     .showType(false)
    ///
    ///     descriptor.value(for: \.name)
    /// }
    /// .showType()
    ///
    /// // BasicModel
    /// //  ├─details
    /// //  │ ├─name: "dog"
    /// //  │ ╰─age: 11
    /// //  ╰─name: "dog" <String>
    /// ```
    func showType(_ bool: Bool = true) -> any DescriptionBlockProtocol {
        self.environment(.showType, value: bool)
    }
    
}
