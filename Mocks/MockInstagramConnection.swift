//
//  MockInstagramConnection.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 12/11/2020.
//

import Foundation

class MockInstagramConnection: InstagramConnectable {
    
    private static var users: [User] = [
        User(id: "1", username: "tim_apple", fullName: "Tim Apple", profilePicture: URL(string: "https://images.pexels.com/photos/4584601/pexels-photo-4584601.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"), private: false, verified: true),
        User(id: "2", username: "manuela", fullName: "Manuela Guedes", profilePicture: URL(string: "https://images.pexels.com/photos/3867206/pexels-photo-3867206.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"), private: false, verified: false)
    ]
    
    func getUser(withUsername username: String, completion: @escaping (Result<User, Error>) -> ()) {
        if let user = Self.users.first(where: { $0.username == username }) {
            completion(.success(user))
        }
    }
    
    func getLatestPosts(forUser user: User, completion: @escaping (Result<[Post], Error>) -> ()) {
        switch user.username {
        case "tim_apple":
            completion(.success([Post(user: user,
                                      shortcode: "2",
                                      urls: .image(urls: [URL(string: "https://images.pexels.com/photos/5623821/pexels-photo-5623821.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260")!]),
                                      likes: 200,
                                      caption: "Sandy leaves...",
                                      date: Date() - 1000,
                                      location: nil,
                                      aspectRatio: 0.5,
                                      savedPost: false)]))
            
        case "manuela":
            completion(.success([Post(user: user,
                                      shortcode: "1",
                                      urls: .image(urls: [URL(string: "https://images.pexels.com/photos/5764070/pexels-photo-5764070.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260")!]),
                                      likes: 100,
                                      caption: "Can you smell it?",
                                      date: Date(),
                                      location: nil,
                                      aspectRatio: 1.5,
                                      savedPost: false)]))
            
        default:
            ()
        }
    }
    
    func search(query: String, completion: @escaping (Result<[User], Error>) -> ()) {
        completion(.success(Self.users))
    }
}
