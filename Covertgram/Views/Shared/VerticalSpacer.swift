//
//  VerticalSpacer.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 17/11/2020.
//

import SwiftUI

struct VerticalSpacer: View {
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.001)
            Spacer()
        }
        .frame(minWidth: width,
               idealWidth: width,
               maxWidth: width,
               minHeight: height,
               idealHeight: height,
               maxHeight: height,
               alignment: .center)
    }
}

#if DEBUG
struct VerticalSpacer_Previews: PreviewProvider {
    
    static var previews: some View {
        VerticalSpacer(width: 10, height: 10)
    }
}
#endif
