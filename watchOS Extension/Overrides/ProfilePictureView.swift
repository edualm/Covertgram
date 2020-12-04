//
//  ProfilePictureView.swift
//  watchOS Extension
//
//  Created by Eduardo Almeida on 17/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfilePictureView: View {
    
    let url: URL
    
    var body: some View {
        WebImage(url: url)
            .resizable()
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: 32, height: 32)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
    }
}

#if DEBUG
struct ProfilePictureView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfilePictureView(url: MockData.Users.eefjah.profilePicture!)
    }
}
#endif
