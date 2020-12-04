//
//  EmptyFeedView.swift
//  watchOS Extension
//
//  Created by Eduardo Almeida on 17/11/2020.
//

import SwiftUI

struct EmptyFeedView: View {
    
    let retryHandler: (() -> ())
    
    let everySecondTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView {
            Image(systemName: "tray")
                .font(.largeTitle)
                .padding(.bottom)
            
            Text("Your feed is empty!")
                .font(.headline)
                .padding(.bottom)
            
            Text("Please sync the accounts you want to follow on the Settings tab of the iPhone app!")
                .multilineTextAlignment(.center)
                .padding(.bottom)
        }.onReceive(everySecondTimer, perform: { _ in
            retryHandler()
        })
    }
}

#if DEBUG
struct EmptyFeedView_Previews: PreviewProvider {
    
    static var previews: some View {
        EmptyFeedView { }
    }
}
#endif
