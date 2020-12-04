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
                
                let windowSize = CGSize(width: scene.screen.bounds.width * 0.2 * 1.3,
                                        height: scene.screen.bounds.height * 0.8 * 1.3)
                
                scene.sizeRestrictions?.minimumSize = windowSize
                scene.sizeRestrictions?.maximumSize = windowSize
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250)) {
                    scene.sizeRestrictions?.minimumSize = CGSize(width: 0, height: 0)
                    scene.sizeRestrictions?.maximumSize = CGSize(width: Int.max, height: Int.max)
                }
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
