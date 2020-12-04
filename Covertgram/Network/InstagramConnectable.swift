//
//  InstagramConnectable.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 12/11/2020.
//

import Foundation

protocol InstagramConnectable {
    
    func getUser(withUsername username: String, completion: @escaping (Result<User, Error>) -> ())
    func getLatestPosts(forUser user: User, completion: @escaping (Result<[Post], Error>) -> ())
    func search(query: String, completion: @escaping (Result<[User], Error>) -> ())
}
