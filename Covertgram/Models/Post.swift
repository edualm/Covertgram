//
//  Post.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 06/11/2020.
//

import Foundation

struct Post: Identifiable {
    
    var id: String {
        shortcode + (savedPost ? "-saved" : "-unsaved")
    }
    
    enum URLKind {
        
        case image(urls: [URL])
        case video(previewURL: URL, url: URL)
    }
    
    let user: User
    
    let shortcode: String
    
    let urls: URLKind
    
    let likes: Int
    
    let caption: String?
    let date: Date
    let location: String?
    
    let aspectRatio: Double
    
    let savedPost: Bool
    
    var shareableURL: URL {
        URL(string: "https://instagram.com/p/\(shortcode)")!
    }
    
    func withSavedState(saved: Bool) -> Post {
        Post(user: user,
             shortcode: shortcode,
             urls: urls,
             likes: likes,
             caption: caption,
             date: date,
             location: location,
             aspectRatio: aspectRatio,
             savedPost: saved)
    }
}

extension Post {
    
    init?(user: User, data: InstagramResponse.Profile.Data.User.EdgeOwnerToTimelineMedia.Edge.Node) {
        self.user = user
        
        self.shortcode = data.shortcode
        
        if let childrenImages = data.edgeSidecarToChildren?.edges {
            self.urls = .image(urls: childrenImages.compactMap {
                URL(string: $0.node.displayResources.last?.src ?? "")
            })
        } else {
            guard let src = data.displayResources.last?.src else {
                return nil
            }
            
            guard let imageURL = URL(string: src) else {
                return nil
            }
            
            if let videoUrl = data.videoUrl {
                self.urls = .video(previewURL: imageURL, url: URL(string: videoUrl)!)
            } else {
                self.urls = .image(urls: [imageURL])
            }
        }
        
        self.likes = data.edgeMediaPreviewLike.count
        
        self.caption = data.edgeMediaToCaption.edges.first?.node.text
        self.date = Date(timeIntervalSince1970: data.takenAtTimestamp)
        self.location = data.location?.name
        
        self.aspectRatio = Double(data.dimensions.width) / Double(data.dimensions.height)
        
        self.savedPost = false
    }
}

extension Post: Hashable {}
extension Post.URLKind: Hashable {}
