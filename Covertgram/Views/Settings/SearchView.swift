//
//  SearchView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 08/11/2020.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var searchText: String = ""
    
    @StateObject var presenter: SearchPresenter = SearchPresenter()
    
    var body: some View {
        let isPresentingAlert = Binding<Bool>(
            get: {
                presenter.viewModel.presentedAlert != nil
            },
            set: {
                if $0 == false {
                    presenter.perform(.dismissAlert)
                }
            }
        )
        
        VStack {
            SearchBar(text: $searchText)
                .padding(.top)
            
            List {
                ForEach(presenter.viewModel.searchResults, id: \.self) { user in
                    SearchResultRowView(user: user)
                        .onTapGesture {
                            presenter.perform(.startFollowing(user: user))
                        }
                }
            }
        }.onChange(of: searchText, perform: {
            presenter.perform(.search(for: $0))
        })
        .alert(isPresented: isPresentingAlert) {
            Alert(
                title: Text(presenter.viewModel.presentedAlert?.title ?? ""),
                message: Text(presenter.viewModel.presentedAlert?.message ?? ""),
                dismissButton: .default(Text("Ok"))
            )
        }
        .navigationTitle("Search")
    }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchView()
    }
}
#endif
