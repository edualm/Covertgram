//
//  SettingsView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 06/11/2020.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var presenter = SettingsPresenter()
    
    var body: some View {
        VStack {
            List {
                if presenter.viewModel.accounts.count > 0 {
                    Section(header: Text("Followees").padding(.top)) {
                        ForEach(presenter.viewModel.accounts, id: \.self) { username in
                            AccountRowView(name: username, presenter: presenter)
                        }
                    }
                }
                
                NavigationLink(destination: SearchView()) {
                    Label("Search Users", systemImage: "person.crop.circle.badge.plus")
                }
                
                Section(footer: WatchSyncStateView(state: presenter.viewModel.watchSyncState)) {
                    if DataTransferManager.shared.supported {
                        Button(action: {
                            presenter.perform(.syncWithAppleWatch)
                        }, label: {
                            Label("Sync with Apple Watch", systemImage: "applewatch.radiowaves.left.and.right")
                        })
                    }
                }
                
                
            }
            .listStyle(InsetGroupedListStyle())
            .onAppear {
                self.presenter.perform(.onAppear)
            }
        }
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView()
    }
}
#endif
