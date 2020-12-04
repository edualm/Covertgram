//
//  PostTopLineView.swift
//  watchOS Extension
//
//  Created by Eduardo Almeida on 17/11/2020.
//

import SwiftUI

struct PostTopLineView: View {
    
    let post: Post
    
    var body: some View {
        HStack {
            Group {
                if let url = post.user.profilePicture {
                    ProfilePictureView(url: url)
                        
                }
                VStack(alignment: .leading) {
                    Spacer()
                    if let displayName = post.user.displayName.decodedUnicodeString {
                        Text(displayName)
                            .font(.system(size: 12))
                            .fontWeight(.bold)
                    }
                    if let location = post.location {
                        Text(location)
                            .font(.system(size: 10))
                    }
                    Spacer()
                }.frame(height: 40)
            }
            Spacer()
        }.padding(.bottom, 4)
    }
}

#if DEBUG
struct UserLineView_Previews: PreviewProvider {
    
    static var previews: some View {
        PostTopLineView(post: MockData.Posts.eefjah)
            .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 6 - 40mm"))
    }
}
#endif
