//
//  SavedPresenter.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 16/11/2020.
//

import Foundation

class SavedPresenter: ObservableObject {
    
    enum Action {
        
        case delete(Post)
        case loadData
    }
    
    enum ViewModel {
        
        case data([Post])
        case empty
    }
    
    @Published var viewModel: ViewModel
    
    init() {
        self.viewModel = .empty
        
        loadData()
    }
    
    private func loadData() {
        let posts = StoredPost
            .get(withManagedContext: Persistence.default.persistentContainer.viewContext)
            .sorted { $0.date > $1.date }
        
        guard posts.count > 0 else {
            self.viewModel = .empty
            
            return
        }
        
        self.viewModel = .data(posts.map { $0.post })
    }
    
    func perform(_ action: Action) {
        switch action {
        case .delete(let post):
            guard let storedPost = StoredPost.get(withManagedContext: Persistence.default.persistentContainer.viewContext).first(where: { $0.shortcode == post.shortcode }) else {
                assertionFailure("Deletion error!")
                
                return
            }
            
            storedPost.delete(withManagedContext: Persistence.default.persistentContainer.viewContext)
            
            loadData()
            
        case .loadData:
            loadData()
        }
    }
}
