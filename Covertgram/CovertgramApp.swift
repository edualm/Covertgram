//
//  CovertgramApp.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 06/11/2020.
//

import SwiftUI

@main
struct CovertgramApp: App {
    
    func onAppear() {
        #if targetEnvironment(macCatalyst)
        DispatchQueue.once {
            UIApplication.shared.connectedScenes.forEach {
                guard let scene = $0 as? UIWindowScene else {
                    return
                }
                
                scene.titlebar?.titleVisibility = .hidden
                scene.titlebar?.toolbar = nil
            }
        }
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: onAppear)
        }
    }
}
