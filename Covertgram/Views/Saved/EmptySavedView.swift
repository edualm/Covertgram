//
//  EmptySavedView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 16/11/2020.
//

import SwiftUI

struct EmptySavedView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "bookmark")
                .font(.largeTitle)
                .padding(.bottom)
            
            Text("No saved posts!")
                .font(.headline)
                .padding(.bottom)
            
            Text("You haven't saved any posts yet.\n\nSaving a post makes it show up here, and available for you to see even when you don't have an internet connection!")
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing])
        }
    }
}

#if DEBUG
struct EmptySavedView_Previews: PreviewProvider {
    
    static var previews: some View {
        EmptySavedView()
    }
}
#endif
