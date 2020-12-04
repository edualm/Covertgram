//
//  FeedView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 06/11/2020.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var presenter = FeedPresenter()
    
    var body: some View {
        let pullToRefreshLoading = Binding<Bool>(
            get: {
                if case let FeedPresenter.ViewModel.data(_, state, _) = presenter.viewModel {
                    return state
                }
                
                return false
            }, set: {
                if $0 {
                    presenter.perform(.pullToRefresh)
                }
            }
        )
        
        return Group {
            switch presenter.viewModel {
            case .data(let posts, _, let isSaving):
                GeometryReader { geo in
                    RefreshableScrollView(refreshing: pullToRefreshLoading) {
                        LazyVStack {
                            ForEach(posts, id: \.self) { post in
                                VStack {
                                    PostView(post: post,
                                             saveHandler: { post in
                                                presenter.perform(.save(post))
                                             },
                                             deleteHandler: { post in
                                                presenter.perform(.delete(post))
                                             },
                                             maxPostHeight: geo.size.height - 125)
                                }
                            }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                        }
                    }
                    .disabled(isSaving)
                    .overlay(isSaving ? AnyView(SpinnerOverlay()) : AnyView(EmptyView()))
                }
            case let .error(title, message):
                ErrorFeedView(title: title, message: message, retryHandler: { presenter.perform(.retry) })
                    .padding()
            case .loading:
                LoadingFeedView()
                    .padding()
            case .noAccounts:
                EmptyFeedView()
                    .padding()
            }
        }
        .onAppear {
            presenter.perform(.onAppear)
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
