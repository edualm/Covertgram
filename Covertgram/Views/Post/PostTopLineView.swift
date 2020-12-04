//
//  PostTopLineView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 07/11/2020.
//

import SwiftUI

struct PostTopLineView: View {
    
    @Environment(\.openURL) var openURL
    
    let post: Post
    let saveHandler: PostView.PostActionHandler?
    let deleteHandler: PostView.PostActionHandler?
    
    var body: some View {
        HStack {
            Group {
                if let url = post.user.profilePicture {
                    ProfilePictureView(url: url)
                        .padding(.leading)
                }
                VStack(alignment: .leading) {
                    Spacer()
                    if let displayName = post.user.displayName.decodedUnicodeString {
                        Text(displayName)
                            .fontWeight(.bold)
                    }
                    if let location = post.location {
                        Text(location)
                            .font(.caption)
                    }
                    Spacer()
                }.frame(height: 26)
            }.onTapGesture {
                openURL(post.user.profileURL)
            }
            Spacer()
            if post.savedPost {
                Button(action: {
                    deleteHandler?(post)
                }) {
                    Image(systemName: "bookmark.fill")
                }
            } else {
                Button(action: {
                    saveHandler?(post)
                }) {
                    Image(systemName: "bookmark")
                }
            }
            
            ShareSheetView(url: post.shareableURL)
            
            Button(action: {
                openURL(post.shareableURL)
            }) {
                Image(systemName: "ellipsis")
            }.padding(.trailing)
        }.padding(.bottom, 4)
    }
}

#if DEBUG
struct UserLineView_Previews: PreviewProvider {
    
    static var previews: some View {
        PostTopLineView(post: MockData.Posts.eefjah, saveHandler: nil, deleteHandler: nil)
    }
}
#endif
