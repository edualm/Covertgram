//
//  Persistence.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 16/11/2020.
//

import Foundation
import CoreData

class Persistence {
    
    static let `default` = Persistence()
    
    let persistentContainer = NSPersistentContainer.default
    
    private init() {
        
    }
}
