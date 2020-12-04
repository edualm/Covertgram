//
//  User.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 06/11/2020.
//

import Foundation

struct User {
    
    let id: String
    let username: String
    let fullName: String
    let profilePicture: URL?
    
    let `private`: Bool?
    let verified: Bool
    
    var profileURL: URL {
        URL(string: "https://instagram.com/\(username)")!
    }
    
    var displayName: String {
        fullName.count > 0 ? fullName : username
    }
}

extension User: Hashable {}

extension User {
    
    init(data: InstagramResponse.Search.UserEntry.User) {
        
        self.id = data.pk
        self.username = data.username
        self.fullName = data.fullName
        self.profilePicture = data.profilePicUrl
        self.verified = data.isVerified
        self.private = data.isPrivate
    }
}
