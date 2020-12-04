//
//  EnvironmentResolver.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 12/11/2020.
//

import Foundation

enum EnvironmentResolver {
    
    static private var isMockEnvironment: Bool {
        ProcessInfo.processInfo.environment["env"] == "mock"
    }
    
    static var instagramConnection: InstagramConnectable {
        if isMockEnvironment {
            return MockInstagramConnection()
        } else {
            return InstagramConnection()
        }
    }
    
    static var storageProvider: StorageProvider {
        if isMockEnvironment {
            return MockStorageProvider()
        } else {
            return UserDefaults.standard
        }
    }
}
