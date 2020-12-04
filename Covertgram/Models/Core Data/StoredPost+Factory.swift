//
//  StoredPost+Factory.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 16/11/2020.
//

import CoreData

extension StoredPost {
    
    enum Factory {
        
        enum StoredPostCreationError: Error {
            case saveError
        }
        
        public static func create(withManagedContext managedContext: NSManagedObjectContext, post: Post, completion: @escaping (Result<StoredPost, StoredPostCreationError>) -> ()) {
            
            let semaphore = DispatchSemaphore(value: 1)
            
            var networkConnectionsRemaining = 0
            
            let storedPost = StoredPost.new(withManagedContext: managedContext)
            
            storedPost.aspectRatio = post.aspectRatio
            storedPost.caption = post.caption
            storedPost.date = post.date
            storedPost.location = post.location
            storedPost.shortcode = post.shortcode
            
            storedPost.userFullName = post.user.fullName
            storedPost.userId = post.user.id
            storedPost.userIsVerified = post.user.verified
            storedPost.userUsername = post.user.username
            
            storedPost.files = {
                switch post.urls {
                case .image(let urls):
                    return urls.map { $0.absoluteString }
                    
                case .video(_, let url):
                    return [url.absoluteString]
                }
            }()
            
            let checkIsFinished = {
                semaphore.wait()
                
                defer {
                    semaphore.signal()
                }
                
                if networkConnectionsRemaining == 0 {
                    do {
                        try managedContext.save()
                    } catch {
                        managedContext.delete(storedPost)
                        try? managedContext.save()
                        
                        completion(.failure(.saveError))
                        
                        return
                    }
                    
                    completion(.success(storedPost))
                }
            }
            
            var dataTasks: [URLSessionDataTask] = []
            
            switch post.urls {
            case .image(let urls):
                storedPost.kind = Kind.image.rawValue
                
                networkConnectionsRemaining += urls.count
                
                (0...(urls.count - 1)).forEach { index in
                    let dataTask = URLSession(configuration: .default).dataTask(with: urls[index]) { data, response, error in
                        defer {
                            networkConnectionsRemaining -= 1
                            
                            checkIsFinished()
                        }
                        
                        guard error == nil, let data = data else {
                            return
                        }
                        
                        do {
                            let id = "\(UUID().uuidString).\(urls[index].pathExtension)"
                            
                            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(id)
                            
                            try data.write(to: fileURL)
                            
                            storedPost.files[index] = id
                        } catch {
                            print(error)
                            
                            return
                        }
                    }
                    
                    dataTasks.append(dataTask)
                }
                
            case .video(_, let url):
                storedPost.kind = Kind.video.rawValue
                
                networkConnectionsRemaining += 1
                
                let dataTask = URLSession(configuration: .default).dataTask(with: url) { data, response, error in
                    defer {
                        networkConnectionsRemaining -= 1
                        
                        checkIsFinished()
                    }
                    
                    guard error == nil, let data = data else {
                        return
                    }
                    
                    do {
                        let id = "\(UUID().uuidString).\(url.pathExtension)"
                        
                        let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(id)
                        
                        try data.write(to: fileURL)
                        
                        storedPost.files[0] = id
                    } catch {
                        print(error)
                        
                        return
                    }
                }
                
                dataTasks.append(dataTask)
            }
            
            if let profilePictureURL = post.user.profilePicture {
                networkConnectionsRemaining += 1
                
                let dataTask = URLSession(configuration: .default).dataTask(with: profilePictureURL) { data, response, error in
                    defer {
                        networkConnectionsRemaining -= 1
                        
                        checkIsFinished()
                    }
                    
                    guard error == nil, let data = data else {
                        return
                    }
                    
                    do {
                        let id = "\(UUID().uuidString).\(profilePictureURL.pathExtension)"
                        
                        let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(id)
                        
                        try data.write(to: fileURL)
                        
                        storedPost.userProfilePicture = id
                    } catch {
                        print(error)
                        
                        return
                    }
                }
                
                dataTasks.append(dataTask)
            }
            
            dataTasks.forEach { $0.resume() }
        }
    }
}
