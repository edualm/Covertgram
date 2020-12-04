//
//  ErrorFeedView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 08/11/2020.
//

import SwiftUI

struct ErrorFeedView: View {
    
    let title: String?
    let message: String?
    let retryHandler: (() -> ())
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .padding(.bottom)
            
            if let title = title {
                Text(title)
                    .font(.headline)
                    .padding(.bottom)
            }
            
            #if !os(watchOS)
            if let message = message {
                Text(message)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
            }
            #endif
            
            Text("Retry")
                .foregroundColor(.black)
                .padding()
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .background(Color.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .onTapGesture {
                    retryHandler()
                }
        }
    }
}

#if DEBUG
struct ErrorFeedView_Previews: PreviewProvider {
    
    static var previews: some View {
        ErrorFeedView(title: "Title", message: "Message", retryHandler: { })
    }
}
#endif
