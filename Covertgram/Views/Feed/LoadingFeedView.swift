//
//  LoadingFeedView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 07/11/2020.
//

import SwiftUI

struct LoadingFeedView: View {
    
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5, anchor: .center)
                .padding(.bottom)
            
            Text("Loading your feed...")
                .font(.caption)
        }
    }
}

#if DEBUG
struct LoadingFeedView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoadingFeedView()
    }
}
#endif
