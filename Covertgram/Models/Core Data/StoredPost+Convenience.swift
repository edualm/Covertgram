//
//  StoredPost+Convenience.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 16/11/2020.
//

import Foundation

extension StoredPost {
    
    var post: Post {
        let urls: Post.URLKind = {
            switch kind {
            case Kind.image.rawValue:
                return .image(urls: files.map {
                    if $0.hasPrefix("https://") {
                        return URL(string: $0)!
                    }
                    
                    return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent($0)
                    
                })
                
            case Kind.video.rawValue:
                let fileId = files[0]
                
                let url: URL
                
                if fileId.hasPrefix("https://") {
                    url = URL(string: fileId)!
                } else {
                    url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fileId)
                }
                
                return .video(previewURL: url, url: url)
                
            default:
                fatalError("Unknown post kind!")
            }
        }()
        
        let profilePictureURL: URL? = {
            guard let id = userProfilePicture else {
                return nil
            }
            
            return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(id)
        }()
        
        return Post(user: User(id: userId,
                               username: userUsername,
                               fullName: userFullName ?? userUsername,
                               profilePicture: profilePictureURL,
                               private: false,
                               verified: userIsVerified),
                    shortcode: shortcode,
                    urls: urls,
                    likes: -1,
                    caption: caption,
                    date: date,
                    location: location,
                    aspectRatio: aspectRatio,
                    savedPost: true)
    }
}
