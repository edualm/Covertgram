//
//  PostView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 06/11/2020.
//

import SwiftUI

struct PostView: View {
    
    typealias PostActionHandler = ((Post) -> ())
    
    @State var index = 0
    
    let post: Post
    let maxPostHeight: CGFloat?
    let saveHandler: PostActionHandler?
    let deleteHandler: PostActionHandler?
    
    init(post: Post, saveHandler: PostActionHandler? = nil, deleteHandler: PostActionHandler? = nil, maxPostHeight: CGFloat? = nil) {
        self.post = post
        self.saveHandler = saveHandler
        self.deleteHandler = deleteHandler
        self.maxPostHeight = maxPostHeight
    }
    
    var showAsSaved: Bool {
        post.savedPost && saveHandler == nil
    }
    
    var body: some View {
        VStack {
            PostTopLineView(post: post, saveHandler: saveHandler, deleteHandler: deleteHandler)
                .padding(.top, 4)
            
            switch post.urls {
            case .image(let urls):
                switch urls.count {
                case 0:
                    EmptyView()
                    
                case 1:
                    PostImageView(url: urls.first!)
                        .frame(maxHeight: maxPostHeight)
                        .aspectRatio(CGFloat(post.aspectRatio), contentMode: .fill)
                    
                default:
                    PagingView(index: $index.animation(), maxIndex: urls.count - 1) {
                        ForEach(urls, id: \.self) { url in
                            PostImageView(url: url)
                        }
                    }
                    .frame(maxHeight: maxPostHeight)
                    .aspectRatio(CGFloat(post.aspectRatio), contentMode: .fill)
                }
                
            case .video(_, let url):
                PostVideoPlayerView(url: url)
                    .frame(maxHeight: maxPostHeight)
                    .aspectRatio(CGFloat(post.aspectRatio), contentMode: .fill)
            }
            
            if let caption = post.caption {
                HStack {
                    Text(caption)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 0)
                }
                .padding([.leading, .trailing])
                .padding(.top, 4)
            }
            
            HStack {
                if !showAsSaved {
                    Label("\(post.likes != -1 ? "\(post.likes)" : "N/A") likes", systemImage: "hand.thumbsup")
                        .scaledToFit()
                        .minimumScaleFactor(0.01)
                    Spacer()
                }
                Label("\(post.date, style: .date) \(post.date, style: .time)", systemImage: "calendar")
                    .scaledToFit()
                    .minimumScaleFactor(0.01)
                if showAsSaved {
                    Spacer()
                }
            }
            .font(.footnote)
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 4)
        }
    }
}

#if DEBUG
struct PostView_Previews: PreviewProvider {
    
    static var previews: some View {
        PostView(post: MockData.Posts.eefjah)
    }
}
#endif
