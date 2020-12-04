//
//  InstagramConnection.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 06/11/2020.
//

import Foundation

class InstagramConnection: InstagramConnectable {
    
    enum InstagramConnectionError: Error {
        case parseFailure
        case requestFailure
    }
    
    static private let Endpoint = "https://www.instagram.com/graphql/query/"
    static private let SearchEndpoint = "https://www.instagram.com/web/search/topsearch/"
    
    enum QueryHash: String {
        case pictures = "003056d32c2554def87228bc3fd9668a"
        case stories = ""
    }
    
    func getUser(withUsername username: String, completion: @escaping (Result<User, Error>) -> ()) {
        let dataTask = URLSession(configuration: .default).dataTask(with: URL(string: "https://instagram.com/\(username)/?__a=1")!) { data, response, error in
            guard error == nil, let data = data else {
                completion(.failure(InstagramConnectionError.requestFailure))
                
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let response = try decoder.decode(InstagramResponse.User.self, from: data)
                
                let user = response.graphql.user
                
                completion(.success(User(id: user.id,
                                         username: user.username,
                                         fullName: user.fullName,
                                         profilePicture: URL(string: user.profilePicUrl ?? ""),
                                         private: user.isPrivate,
                                         verified: user.isVerified)))
            } catch {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
    
    func getLatestPosts(forUser user: User, completion: @escaping (Result<[Post], Error>) -> ()) {
        guard var urlComponents = URLComponents(string: Self.Endpoint) else {
            fatalError("Unable to initialize an URL components instance from the hard-coded endpoint!")
        }
        
        urlComponents.query = "query_hash=003056d32c2554def87228bc3fd9668a&variables={\"id\":\"\(user.id)\",\"first\":10}"
        
        let dataTask = URLSession(configuration: .default).dataTask(with: urlComponents.url!) { data, response, error in
            guard error == nil, let data = data else {
                completion(.failure(InstagramConnectionError.requestFailure))
                
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let response = try decoder.decode(InstagramResponse.Profile.self, from: data)
                
                completion(.success(response.data.user.edgeOwnerToTimelineMedia.edges.compactMap {
                    Post(user: user, data: $0.node)
                }))
            } catch {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
    
    func search(query: String, completion: @escaping (Result<[User], Error>) -> ()) {
        guard var urlComponents = URLComponents(string: Self.SearchEndpoint) else {
            fatalError("Unable to initialize an URL components instance from the hard-coded endpoint!")
        }
        
        urlComponents.query = "query=\(query)"
        
        let dataTask = URLSession(configuration: .default).dataTask(with: urlComponents.url!) { data, response, error in
            guard error == nil, let data = data else {
                completion(.failure(error!))
                
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let response = try decoder.decode(InstagramResponse.Search.self, from: data)
                
                completion(.success(response.users.map {
                    User(data: $0.user)
                }))
            } catch {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
}
