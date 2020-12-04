//
//  MockStorageProvider.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 15/11/2020.
//

import Foundation

class MockStorageProvider: StorageProvider {
    
    func bool(forKey defaultName: String) -> Bool {
        true
    }
    
    func array(forKey defaultName: String) -> [Any]? {
        ["tim_apple", "manuela"]
    }
    
    func setValue(_ value: Any?, forKey key: String) {}
}
