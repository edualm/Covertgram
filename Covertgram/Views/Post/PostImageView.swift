//
//  PostImageView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 09/11/2020.
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
                    .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
            }
        }
    }
    
    @Environment(\.rootViewController) private var viewControllerHolder: UIViewController?
    
    let url: URL
    
    func dismiss() {
        viewControllerHolder?.dismiss(animated: true)
    }
    
    var body: some View {
        GeometryReader { geo in
            ImageView(url: url)
                .onTapGesture {
                    self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
                        VStack {
                            VerticalSpacer(width: UIScreen.main.bounds.width,
                                           height: (UIScreen.main.bounds.height - geo.size.height) / 2 - 50)
                            
                            ImageView(url: url)
                                .pinchToZoom()
                            
                            VerticalSpacer(width: UIScreen.main.bounds.width,
                                           height: (UIScreen.main.bounds.height - geo.size.height) / 2 - 50)
                        }.onTapGesture(perform: dismiss)
                    }
                }
        }
    }
}

#if DEBUG
struct PostImageView_Previews: PreviewProvider {
    
    static var previews: some View {
        PostImageView(url: MockData.Users.eefjah.profilePicture!)
    }
}
#endif
