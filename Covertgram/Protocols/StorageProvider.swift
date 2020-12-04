//
//  StorageProvider.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 07/11/2020.
//

import Foundation

protocol StorageProvider {
    
    func bool(forKey defaultName: String) -> Bool
    func array(forKey defaultName: String) -> [Any]?
    func setValue(_ value: Any?, forKey key: String)
}

extension StorageProvider {
    
    var accountsKey: String { "Accounts" }
    var onboardedKey: String { "Onboarded" }
}

extension UserDefaults: StorageProvider {}
