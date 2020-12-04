//
//  CovertgramApp.swift
//  watchOS Extension
//
//  Created by Eduardo Almeida on 17/11/2020.
//

import SwiftUI

@main
struct CovertgramApp: App {
    
    func onAppear() {
        DataTransferManager.shared.activate()
    }
    
    var body: some Scene {
        WindowGroup {
            FeedView()
                .navigationTitle("Feed")
                .onAppear { onAppear() }
        }
    }
}
