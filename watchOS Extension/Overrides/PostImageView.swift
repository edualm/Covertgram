//
//  PostImageView.swift
//  watchOS Extension
//
//  Created by Eduardo Almeida on 17/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostImageView: View {
    
    struct ImageView: View {
        
        let url: URL
        
        var body: some View {
            HStack {
                WebImage(url: url)
                    .resizable()
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
            }
        }
    }
    
    let url: URL
    
    var body: some View {
        ImageView(url: url)
    }
}

#if DEBUG
struct PostImageView_Previews: PreviewProvider {
    
    static var previews: some View {
        PostImageView(url: MockData.Users.eefjah.profilePicture!)
    }
}
#endif
