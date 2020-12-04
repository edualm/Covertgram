//
//  SpinnerOverlay.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 16/11/2020.
//

import SwiftUI

struct SpinnerOverlay: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(1.5, anchor: .center)
            .padding(32)
            .background(colorScheme == .dark ? Color.gray : Color(UIColor.lightGray))
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}

#if DEBUG
struct SpinnerOverlay_Previews: PreviewProvider {
    
    static var previews: some View {
        SpinnerOverlay()
    }
}
#endif
