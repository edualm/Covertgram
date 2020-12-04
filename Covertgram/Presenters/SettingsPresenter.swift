//
//  SettingsPresenter.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 07/11/2020.
//

import Foundation

class SettingsPresenter: ObservableObject {
    
    enum Action {
        
        case onAppear
        case stopFollowing(username: String)
        case syncWithAppleWatch
    }
    
    struct ViewModel {
        
        enum WatchSyncState {
            case failure(error: Error)
            case success
            
            case unknown
            
            case working
        }
        
        let accounts: [String]
        let showSyncWithWatch: Bool
        let watchSyncState: WatchSyncState
        
        init(accounts: [String], showSyncWithWatch: Bool, watchSyncState: WatchSyncState) {
            self.accounts = accounts.sorted()
            self.showSyncWithWatch = showSyncWithWatch
            self.watchSyncState = watchSyncState
        }
    }
    
    @Published var viewModel: ViewModel
    
    private let storage: StorageProvider
    
    private static var showSyncWithWatch: Bool {
        DataTransferManager.shared.supported
    }
    
    init(storage: StorageProvider = EnvironmentResolver.storageProvider) {
        self.storage = storage
        self.viewModel = ViewModel(
            accounts: storage.array(forKey: storage.accountsKey) as? [String] ?? [],
            showSyncWithWatch: Self.showSyncWithWatch,
            watchSyncState: .unknown
        )
    }
    
    func perform(_ action: Action) {
        switch action {
        case .onAppear:
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) { [weak self] in
                guard let self = self else { return }
                
                self.viewModel = ViewModel(
                    accounts: self.storage.array(forKey: self.storage.accountsKey) as? [String] ?? [],
                    showSyncWithWatch: Self.showSyncWithWatch,
                    watchSyncState: self.viewModel.watchSyncState
                )
            }
            
        case .stopFollowing(let username):
            viewModel = ViewModel(
                accounts: viewModel.accounts.filter { $0 != username },
                showSyncWithWatch: Self.showSyncWithWatch,
                watchSyncState: viewModel.watchSyncState
            )
            
            storage.setValue(viewModel.accounts, forKey: storage.accountsKey)
        
        case .syncWithAppleWatch:
            viewModel = ViewModel(
                accounts: self.viewModel.accounts,
                showSyncWithWatch: Self.showSyncWithWatch,
                watchSyncState: .working
            )
            
            DataTransferManager.shared.sendUpdateToWatch { error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.viewModel = ViewModel(
                            accounts: self.viewModel.accounts,
                            showSyncWithWatch: Self.showSyncWithWatch,
                            watchSyncState: .failure(error: error)
                        )
                    } else {
                        self.viewModel = ViewModel(
                            accounts: self.viewModel.accounts,
                            showSyncWithWatch: Self.showSyncWithWatch,
                            watchSyncState: .success
                        )
                    }
                }
            }
        }
    }
}
