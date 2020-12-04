//
//  ShareSheetView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 17/11/2020.
//

import SwiftUI

struct ShareSheetView: View {
    
    let url: URL
    
    var body: some View {
        Button(action: actionSheet) {
            Image(systemName: "square.and.arrow.up")
        }
    }
    
    func actionSheet() {
        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}
