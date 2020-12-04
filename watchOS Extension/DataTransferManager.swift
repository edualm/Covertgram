//
//  DataTransferManager.swift
//  watchOS Extension
//
//  Created by Eduardo Almeida on 17/11/2020.
//

import WatchConnectivity

class DataTransferManager: NSObject {
    
    static let shared = DataTransferManager()
    
    func activate() {
        let session = WCSession.default
        session.delegate = self
        
        session.activate()
    }
}

extension DataTransferManager: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //  Do nothing.
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        self.session(session, didReceiveMessage: message) { _ in }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        guard let accountsDataPackage = message["accounts"] as? [String] else {
            replyHandler(["success": false, "error": "Invalid data received."])
            
            return
        }
        
        let storageProvider: StorageProvider = UserDefaults.standard
        
        storageProvider.setValue(accountsDataPackage, forKey: storageProvider.accountsKey)
        
        replyHandler([
            "success": true
        ])
    }
}
