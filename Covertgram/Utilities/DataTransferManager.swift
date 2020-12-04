//
//  DataTransferManager.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 17/11/2020.
//

import WatchConnectivity

class DataTransferManager: NSObject {
    
    static let shared = DataTransferManager()
    
    let storageProvider: StorageProvider = UserDefaults.standard
    
    let supported: Bool
    
    override private init() {
        guard WCSession.isSupported() else {
            print("WatchConnectivity not supported on this device!")
            
            supported = false
            
            super.init()
            
            return
        }
        
        supported = true
        
        super.init()
        
        let session = WCSession.default
        session.delegate = self
        
        session.activate()
    }
    
    func sendUpdateToWatch(completionHandler: ((Error?) -> ())? = nil) {
        WCSession.default.sendMessage(["accounts": storageProvider.array(forKey: storageProvider.accountsKey) ?? []], replyHandler: { _ in
            completionHandler?(nil)
        }, errorHandler: {
            completionHandler?($0)
        })
    }
}

extension DataTransferManager: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if activationState == .activated && session.isReachable {
            sendUpdateToWatch()
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
}
