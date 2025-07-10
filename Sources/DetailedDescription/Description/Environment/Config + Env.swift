//
//  Config + Env.swift
//  DetailedDescription
//
//  Created by Vaida on 2025-06-14.
//

private struct ConfigurationEnvironmentKey<Configuration: Initializable>: EnvironmentKey {
    
    nonisolated(unsafe) static var defaultValue: Configuration {
        Configuration()
    }
    
    typealias Value = Configuration
    
}

extension _EnvironmentValues {
    
    func configuration<Configuration: Initializable>(for configurationType: Configuration.Type) -> Configuration {
        self[ConfigurationEnvironmentKey<Configuration>.self]
    }
    
}


extension DescriptionBlockProtocol {
    
    func environment<Configuration: Initializable>(_ key: Configuration.Type, value: Configuration) -> any DescriptionBlockProtocol {
        self.environment(ConfigurationEnvironmentKey<Configuration>.self, value: value)
    }
    
}


extension DescriptionBlockProtocol {
    
    /// Pass an configuration object to the environment.
    ///
    /// Any block that can adopt the configuration will use the configuration.
    ///
    /// - Note: Similar to SwiftUI environment values, you can only store one instance per type, and the innermost attribute will be adopted.
    public func configuration<Configuration: Initializable>(_ configuration: Configuration) -> any DescriptionBlockProtocol {
        self.environment(Configuration.self, value: configuration)
    }
    
}
