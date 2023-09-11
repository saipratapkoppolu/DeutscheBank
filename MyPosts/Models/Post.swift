//
//  Post.swift
//  MyPosts
//
//  Created by Sai Pratap Koppolu on 11/09/23.
//

import Foundation

struct Post: Identifiable, Codable {
    let id: Int
    let title: String
    let content: String
    var isFavourite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case content = "body"
    }
}

extension Post {
    static var previewData: Post {
        Post(id: 1, title: "Test", content: "Lorem ipsum sample test")
    }
}
