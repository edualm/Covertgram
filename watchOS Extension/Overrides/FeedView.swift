//
//  FeedView.swift
//  watchOS Extension
//
//  Created by Eduardo Almeida on 17/11/2020.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var presenter = FeedPresenter()
    
    var body: some View {
        Group {
            switch presenter.viewModel {
            case .data(let posts):
                GeometryReader { geo in
                    ScrollView {
                        LazyVStack {
                            ForEach(posts, id: \.self) { post in
                                VStack {
                                    PostView(post: post)
                                }
                            }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                        }
                    }
                    .toolbar {
                        Button(action: {
                            presenter.perform(.refresh)
                        }, label: {
                            Label("Refresh", systemImage: "arrow.counterclockwise.circle")
                        })
                    }
                }
            case let .error(title, message):
                ErrorFeedView(title: title, message: message, retryHandler: { presenter.perform(.refresh) })
            case .loading:
                LoadingFeedView()
                    .padding()
            case .noAccounts:
                EmptyFeedView(retryHandler: { presenter.perform(.refresh) })
            }
        }
        .onAppear {
            presenter.perform(.refresh)
        }
    }
}

#if DEBUG
struct FeedView_Previews: PreviewProvider {
    
    static var previews: some View {
        FeedView()
    }
}
#endif
