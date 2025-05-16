//
//  Container + Env.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-05-15.
//

private struct ShowTypeEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool = false
}


extension _EnvironmentValues {
    
    var showType: Bool {
        get { self[ShowTypeEnvironmentKey.self] }
        set { self[ShowTypeEnvironmentKey.self] = newValue }
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
        self.environment(ShowTypeEnvironmentKey.self, value: bool)
    }
    
}
