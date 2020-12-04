//
//  StoredPost.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 16/11/2020.
//

import CoreData

class StoredPost: NSManagedObject {
    
    enum Kind: Int16 {
        case image = 1
        case video = 2
    }
    
    @NSManaged var aspectRatio: Double
    @NSManaged var caption: String?
    @NSManaged var date: Date
    @NSManaged var files: [String]
    @NSManaged var kind: Int16
    @NSManaged var location: String?
    @NSManaged var shortcode: String
    
    @NSManaged var userFullName: String?
    @NSManaged var userId: String
    @NSManaged var userIsVerified: Bool
    @NSManaged var userProfilePicture: String?
    @NSManaged var userUsername: String
}
