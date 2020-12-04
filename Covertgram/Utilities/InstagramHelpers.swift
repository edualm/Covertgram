//
//  InstagramHelpers.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 07/11/2020.
//

import Foundation

enum InstagramHelpers {
    
    enum FeedAcquisitionError: Error {
        
        case noUsers
    }
    
    static func getFeed(for usernames: [String],
                        using instagram: InstagramConnectable = EnvironmentResolver.instagramConnection,
                        completion: @escaping (Result<[Post], Error>) -> ()) {
        
        var remaining = usernames.count
        var users = [User]()
        
        usernames.forEach {
            instagram.getUser(withUsername: $0) {
                switch $0 {
                case .success(let user):
                    users.append(user)
                    
                case .failure:
                    ()
                }
                
                remaining -= 1
                
                if remaining == 0 {
                    if users.count == 0 {
                        completion(.failure(FeedAcquisitionError.noUsers))
                        
                        return
                    }
                    
                    remaining = users.count
                    var posts = [Post]()
                    
                    users.forEach {
                        instagram.getLatestPosts(forUser: $0) {
                            switch $0 {
                            case .success(let userPosts):
                                posts += userPosts
                                
                            case .failure(let error):
                                print(error)
                            }
                            
                            remaining -= 1
                            
                            if remaining == 0 {
                                completion(.success(posts.sorted { $0.date > $1.date }))
                            }
                        }
                    }
                }
            }
        }
    }
}
