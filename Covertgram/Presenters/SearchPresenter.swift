//
//  SearchPresenter.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 08/11/2020.
//

import Foundation

class SearchPresenter: ObservableObject {
    
    enum Action {
        
        case dismissAlert
        case search(for: String)
        case startFollowing(user: User)
    }
    
    enum Alert {
        
        case alreadyFollowing(user: User)
        case privateAccount
        case success(user: User)
        
        var title: String {
            switch self {
            case .alreadyFollowing:
                return "Already Following"
                
            case .success:
                return "Success!"
                
            case .privateAccount:
                return "Private Account"
            }
        }
        
        var message: String {
            switch self {
            case .alreadyFollowing(let user):
                return "You are already \(user.username)!"
                
            case .success(let user):
                return "You are now following \(user.username)!"
                
            case .privateAccount:
                return "Following private accounts is not supported."
            }
        }
    }
    
    struct ViewModel {
        
        let searchResults: [User]
        let presentedAlert: Alert?
        
        init(searchResults: [User] = [], presentedAlert: Alert? = nil) {
            self.searchResults = searchResults
            self.presentedAlert = presentedAlert
        }
    }
    
    @Published var viewModel: ViewModel
    
    private let instagram: InstagramConnectable
    private let storage: StorageProvider
    
    init(instagram: InstagramConnectable = EnvironmentResolver.instagramConnection,
         storage: StorageProvider = EnvironmentResolver.storageProvider) {
        
        self.instagram = instagram
        self.storage = storage
        
        self.viewModel = ViewModel()
    }
    
    func perform(_ action: Action) {
        switch action {
        case .dismissAlert:
            self.viewModel = ViewModel(
                searchResults: viewModel.searchResults,
                presentedAlert: nil
            )
        
        case .search(let query):
            let instagram = InstagramConnection()
            
            instagram.search(query: query) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let users):
                        self.viewModel = ViewModel(
                            searchResults: users,
                            presentedAlert: self.viewModel.presentedAlert
                        )
                        
                    case .failure:
                        ()
                    }
                }
            }
            
        case .startFollowing(let user):
            guard user.private != true else {
                self.viewModel = ViewModel(
                    searchResults: viewModel.searchResults,
                    presentedAlert: .privateAccount
                )
                
                return
            }
            
            let currentFollowees = storage.array(forKey: storage.accountsKey) as? [String] ?? []
            
            guard !currentFollowees.contains(user.username) else {
                self.viewModel = ViewModel(
                    searchResults: viewModel.searchResults,
                    presentedAlert: .alreadyFollowing(user: user)
                )
                
                return
            }
            
            let accountsArray = (storage.array(forKey: storage.accountsKey) ?? []) + [user.username]
            
            storage.setValue(accountsArray, forKey: storage.accountsKey)
            
            self.viewModel = ViewModel(
                searchResults: viewModel.searchResults,
                presentedAlert: .success(user: user)
            )
        }
    }
}
