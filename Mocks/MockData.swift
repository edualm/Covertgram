//
//  MockData.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 07/11/2020.
//

import Foundation

enum MockData {
    
    enum Users {
        
        static var eefjah: User {
            User(id: "0",
                 username: "eefjah",
                 fullName: "Eefje 'sjokz' Depoortere",
                 profilePicture: URLs.eefjahProfilePicture,
                 private: false,
                 verified: true)
        }
        
        static var johnDoe: User {
            User(id: "1",
                 username: "john_doe",
                 fullName: "John Doe",
                 profilePicture: URLs.grayImage,
                 private: false,
                 verified: true)
        }
    }
    
    enum Posts {
        
        static var eefjah: Post {
            Post(user: Users.eefjah,
                 shortcode: "code",
                 urls: .image(urls: [URLs.eefjahPostImage]),
                 likes: 1000,
                 caption: "Livin' la vida loca!",
                 date: Date() - 90,
                 location: "Óbidos, Portugal",
                 aspectRatio: 1,
                 savedPost: false)
        }
        
        static var johnDoe: Post {
            Post(user: Users.johnDoe,
                 shortcode: "code",
                 urls: .image(urls: [URLs.grayImage]),
                 likes: 1000,
                 caption: "Livin' la vida loca!",
                 date: Date() - 90,
                 location: "Óbidos, Portugal",
                 aspectRatio: 1,
                 savedPost: false)
        }
    }
    
    enum URLs {
        
        static var eefjahProfilePicture: URL {
            URL(string: "https://pbs.twimg.com/profile_images/1284795036828393473/rCTZlrFs_400x400.jpg")!
        }
        
        static var eefjahPostImage: URL {
            URL(string: "https://instagram.fopo2-2.fna.fbcdn.net/v/t51.2885-15/sh0.08/e35/s640x640/123142012_212635846893780_1877046624563238881_n.jpg?_nc_ht=instagram.fopo2-2.fna.fbcdn.net&_nc_cat=100&_nc_ohc=KKyhHAWjUmYAX8SvtqA&_nc_tp=24&oh=460f6f1ba0d2b3aa06949b99261a676e&oe=5FCEE984")!
        }
        
        static var grayImage: URL {
            URL(string: "https://www.audi.com/content/dam/ci/Fundamentals/Basics/Colours/04_Grautoene_Elemente/Audi_Brandplattform_Colours_Element-15.png?imwidth=1200")!
        }
        
        static var video: URL {
            URL(string: "https://instagram.fopo2-2.fna.fbcdn.net/v/t50.2886-16/123235928_1758202664329208_7552404395640748655_n.mp4?_nc_ht=instagram.fopo2-2.fna.fbcdn.net&_nc_cat=108&_nc_ohc=CN4tnmy23A4AX9yhM6t&oe=5FA8EB2D&oh=72a11fb8b9fea3d73a1523b46e9dbd88")!
        }
    }
}
