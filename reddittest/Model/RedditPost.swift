//
//  RedditPost.swift
//  reddittest
//
//  Created by Realitian on 2020/10/28.
//  Copyright © 2020 Billy. All rights reserved.
//
import Foundation

struct PostData: Codable {
    struct PostList: Codable {
        struct PostChild: Codable {
            let kind: String
            let data: PostEntity
            
            private enum CodingKeys: String, CodingKey {
                case kind
                case data
            }
        }
        
        let dist: Int
        let children: [PostChild]
        let after: String?
        let before: String?
        
        private enum CodingKeys: String, CodingKey {
            case dist
            case children
            case after
            case before
        }
    }
    
    let kind: String
    let data: PostList
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case data
    }
}

@objc class PostEntity: NSObject, Codable {
    let author: String
    let title: String
    let body: String?
    let htmlBody: String?
    let category: String
    let likes: Int?
    let comments: Int?
    let thumbnail: String?
    let width: Int?
    let height: Int?
    let isVideo: Bool
    let created: Int
    
    private enum CodingKeys: String, CodingKey {
        case author
        case title
        case body = "selftext"
        case htmlBody = "sekftext_html"
        case category = "subreddit_name_prefixed"
        case likes = "ups"
        case comments = "num_comments"
        case thumbnail
        case width = "thumbnail_width"
        case height = "thumbnail_height"
        case isVideo = "is_video"
        case created = "created_utc"
    }
}
