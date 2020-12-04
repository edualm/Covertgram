//
//  EmptyFeedView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 07/11/2020.
//

import SwiftUI

struct EmptyFeedView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "tray")
                .font(.largeTitle)
                .padding(.bottom)
            
            Text("Your feed is empty!")
                .font(.headline)
                .padding(.bottom)
            
            Text("You aren't currently following any accounts. Head over to the Settings tab to fix that!")
                .multilineTextAlignment(.center)
        }
    }
}

#if DEBUG
struct EmptyFeedView_Previews: PreviewProvider {
    
    static var previews: some View {
        EmptyFeedView()
    }
}
#endif
