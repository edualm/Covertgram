//
//  PostView.swift
//  watchOS Extension
//
//  Created by Eduardo Almeida on 17/11/2020.
//

import SwiftUI

struct PostView: View {
    
    typealias PostActionHandler = ((Post) -> ())
    
    @State var index = 0
    
    let post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    var body: some View {
        VStack {
            PostTopLineView(post: post)
                .padding(.top, 4)
            
            switch post.urls {
            case .image(let urls):
                switch urls.count {
                case 0:
                    EmptyView()
                    
                case 1:
                    PostImageView(url: urls.first!)
                        .aspectRatio(CGFloat(post.aspectRatio), contentMode: .fill)
                    
                default:
                    PagingView(index: $index.animation(), maxIndex: urls.count - 1) {
                        ForEach(urls, id: \.self) { url in
                            PostImageView(url: url)
                        }
                    }
                    .aspectRatio(CGFloat(post.aspectRatio), contentMode: .fill)
                }
                
            case .video:
                EmptyView()
            }
            
            if let caption = post.caption {
                HStack {
                    Text(caption)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 0)
                }
                .padding(.top, 4)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Label("\(post.likes) likes", systemImage: "hand.thumbsup")
                    Label("\(post.date, style: .date) \(post.date, style: .time)", systemImage: "calendar")
                }
                Spacer(minLength: 0)
            }
            .font(.system(size: 10))
            .padding([.top, .bottom], 4)
        }
    }
}

#if DEBUG
struct PostView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ScrollView {
                PostView(post: MockData.Posts.eefjah)
                    .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 6 - 40mm"))
            }
            
            ScrollView {
                PostView(post: MockData.Posts.possiblyBuggyCaption)
                    .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 6 - 40mm"))
            }
        }
    }
}
#endif
