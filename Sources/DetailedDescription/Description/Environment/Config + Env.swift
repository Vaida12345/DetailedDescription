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
