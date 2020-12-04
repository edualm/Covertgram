//
//  SavedView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 16/11/2020.
//

import SwiftUI

struct SavedView: View {
    
    @StateObject var presenter = SavedPresenter()
    
    var body: some View {
        Group {
            switch presenter.viewModel {
            case .data(let posts):
                GeometryReader { geo in
                    ScrollView {
                        LazyVStack {
                            ForEach(posts, id: \.self) { post in
                                VStack {
                                    PostView(post: post,
                                             deleteHandler: { post in
                                                presenter.perform(.delete(post))
                                             },
                                             maxPostHeight: geo.size.height - 125)
                                }
                            }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                        }
                    }
                }
            case .empty:
                EmptySavedView()
                    .padding()
            }
        }.onAppear {
            presenter.perform(.loadData)
        }
    }
}

#if DEBUG
struct SavedView_Previews: PreviewProvider {
    
    static var previews: some View {
        SavedView()
    }
}
#endif
