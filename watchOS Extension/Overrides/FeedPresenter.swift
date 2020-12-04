//
//  FeedPresenter.swift
//  watchOS Extension
//
//  Created by Eduardo Almeida on 17/11/2020.
//

import Foundation

class FeedPresenter: ObservableObject {
    
    enum Action {
        
        case refresh
    }
    
    enum ViewModel {
        
        case data(posts: [Post])
        case error(title: String?, message: String?)
        case loading
        case noAccounts
    }
    
    @Published var viewModel: ViewModel
    
    let instagram: InstagramConnectable
    let storage: StorageProvider
    
    init(instagram: InstagramConnectable = EnvironmentResolver.instagramConnection,
         storage: StorageProvider = EnvironmentResolver.storageProvider) {
        
        self.viewModel = .loading

        self.instagram = instagram
        self.storage = storage
    }
    
    private func loadData() {
        let accounts = storage.array(forKey: storage.accountsKey) as? [String] ?? []
        
        guard accounts.count != 0 else {
            viewModel = .noAccounts
            
            return
        }
        
        InstagramHelpers.getFeed(for: accounts) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                
                switch result {
                case .success(let posts):
                    if posts.count > 0 {
                        self.viewModel = .data(posts: posts.filter {
                            if case Post.URLKind.image = $0.urls {
                                return true
                            } else {
                                return false
                            }
                        })
                    } else {
                        self.viewModel = .error(title: "Hmm...", message: "There's nothing to show. You may be hitting Instagram's rate limits - please try again later!")
                    }
                    
                case .failure(let error):
                    self.viewModel = .error(
                        title: "Error!",
                        message: error.localizedDescription
                    )
                }
            }
        }
    }
    
    func perform(_ action: Action) {
        switch action {
        case .refresh:
            viewModel = .loading
            
            loadData()
        }
    }
}
