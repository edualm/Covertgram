//
//  InstagramResponse.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 06/11/2020.
//

import Foundation

enum InstagramResponse {
    
    struct Dimensions: Codable {
        
        let height: Int
        let width: Int
    }
    
    struct DisplayResource: Codable {
        
        let src: String
        let configHeight: Int
        let configWidth: Int
    }
    
    struct Location: Codable {
        
        let name: String
    }
    
    struct PageInfo: Codable {
        
        let hasNextPage: Bool
        let endCursor: String
    }
    
    struct User: Codable {
        
        struct GraphQL: Codable {
            
            struct User: Codable {
                
                let id: String
                let username: String
                let fullName: String
                let profilePicUrl: String?
                let isPrivate: Bool
                let isVerified: Bool
            }
            
            let user: User
        }
        
        let graphql: GraphQL
    }
    
    struct Profile: Codable {
        
        struct Data: Codable {
            
            struct User: Codable {
                
                struct EdgeOwnerToTimelineMedia: Codable {
                    
                    struct Edge: Codable {
                        
                        struct Node: Codable {
                            
                            struct EdgeSidecarToChildren: Codable {
                                
                                struct Edge: Codable {
                                    
                                    struct Node: Codable {
                                        
                                        let dimensions: Dimensions
                                        let displayResources: [DisplayResource]
                                    }
                                    
                                    let node: Node
                                }
                                
                                let edges: [Edge]
                            }
                            
                            struct EdgeMediaToCaption: Codable {
                                
                                struct Node: Codable {
                                    
                                    struct Edge: Codable {
                                        
                                        let text: String
                                    }
                                    
                                    let node: Edge
                                }
                                
                                let edges: [Node]
                            }
                            
                            struct EdgeMediaPreviewLike: Codable {
                                
                                let count: Int
                            }
                            
                            let dimensions: Dimensions
                            let displayResources: [DisplayResource]
                            let edgeMediaToCaption: EdgeMediaToCaption
                            let edgeMediaPreviewLike: EdgeMediaPreviewLike
                            let edgeSidecarToChildren: EdgeSidecarToChildren?
                            let location: Location?
                            let shortcode: String
                            let takenAtTimestamp: Double
                            let videoUrl: String?
                            let videoViewCount: Int?
                        }
                        
                        let node: Node
                    }
                    
                    let count: Int
                    let pageInfo: PageInfo
                    let edges: [Edge]
                }
                
                let edgeOwnerToTimelineMedia: EdgeOwnerToTimelineMedia
            }
            
            let user: User
        }
        
        let data: Data
    }
    
    struct Search: Codable {
        
        struct UserEntry: Codable {
            
            struct User: Codable {
                
                let pk: String
                
                let username: String
                let fullName: String
                
                let isPrivate: Bool
                let isVerified: Bool
                
                let profilePicUrl: URL?
            }
            
            let position: Int
            let user: User
        }
        
        let users: [UserEntry]
    }
}
