//
//  FeedPresenter.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 09/11/2020.
//

import UIKit

class FeedPresenter: ObservableObject {
    
    enum Action {
        
        case onAppear
        case delete(Post)
        case pullToRefresh
        case retry
        case save(Post)
    }
    
    enum ViewModel {
        
        case data(posts: [Post], pullToRefreshIsLoading: Bool, isSaving: Bool)
        case error(title: String?, message: String?)
        case loading
        case noAccounts
    }
    
    @Published var viewModel: ViewModel
    
    var accounts: [String]
    
    let instagram: InstagramConnectable
    let storage: StorageProvider
    
    init(instagram: InstagramConnectable = EnvironmentResolver.instagramConnection,
         storage: StorageProvider = EnvironmentResolver.storageProvider) {
        
        self.viewModel = .loading

        self.accounts = []
        self.instagram = instagram
        self.storage = storage
    }
    
    private var savedPostIDs: [String] {
        StoredPost.get(withManagedContext: Persistence.default.persistentContainer.viewContext).map { $0.shortcode }
    }
    
    private func postsWithSavedState(_ posts: [Post]) -> [Post] {
        posts.map { post in
            post.withSavedState(saved: savedPostIDs.first(where: { post.shortcode == $0 } ) != nil)
        }
    }
    
    private func loadData(force: Bool) {
        let storageAccounts = storage.array(forKey: storage.accountsKey) as? [String] ?? []
        
        if storageAccounts != accounts {
            viewModel = .loading
        } else if case ViewModel.data = viewModel, !force {
            loadLocalData()
            
            return
        }
        
        accounts = storageAccounts
        
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
                        self.viewModel = .data(posts: self.postsWithSavedState(posts), pullToRefreshIsLoading: false, isSaving: false)
                    } else {
                        self.viewModel = .error(title: "Hmm...",
                                                message: "There's nothing to show. You may be hitting Instagram's rate limits - please try again later!")
                    }
                    
                case .failure:
                    self.viewModel = .error(
                        title: "Error!",
                        message: "An error has occurred while acquiring info about the users you are following. You may be hitting Instagram's rate limits - please try again later!"
                    )
                }
            }
        }
    }
    
    private func loadLocalData() {
        guard case let ViewModel.data(posts, _, _) = self.viewModel else {
            assertionFailure("loadLocalData requested without a data view model state!")
            
            return
        }
        
        viewModel = .data(posts: postsWithSavedState(posts), pullToRefreshIsLoading: false, isSaving: false)
    }
    
    func perform(_ action: Action) {
        switch action {
        case .onAppear:
            loadData(force: false)
            
        case .delete(let post):
            guard let storedPost = StoredPost.get(withManagedContext: Persistence.default.persistentContainer.viewContext).first(where: { $0.shortcode == post.shortcode }) else {
                viewModel = .error(title: "Deletion Error!",
                                   message: "An error has occurred while deleting the requested post.\n\nPlease reload your feed and try again.")
                
                return
            }
            
            storedPost.delete(withManagedContext: Persistence.default.persistentContainer.viewContext)
            
            loadLocalData()
            
        case .pullToRefresh:
            UIImpactFeedbackGenerator(style: .medium)
                .impactOccurred()
            
            if case let ViewModel.data(posts, _, isSaving) = viewModel {
                viewModel = .data(posts: posts, pullToRefreshIsLoading: true, isSaving: isSaving)
            }
            
            loadData(force: true)
            
        case .retry:
            viewModel = .loading
            
            loadData(force: true)
            
        case .save(let post):
            if case let ViewModel.data(posts, pullToRefreshIsLoading, _) = viewModel {
                viewModel = .data(posts: posts, pullToRefreshIsLoading: pullToRefreshIsLoading, isSaving: true)
            }
            
            StoredPost.Factory.create(withManagedContext: Persistence.default.persistentContainer.viewContext, post: post) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self?.loadLocalData()
                        
                    case .failure:
                        self?.viewModel = .error(title: "Save Error!",
                                                 message: "An error has occurred while saving the requested post.\n\nPlease reload your feed and try again.")
                    }
                }
            }
        }
    }
}
