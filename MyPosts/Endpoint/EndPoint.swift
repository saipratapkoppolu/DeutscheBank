//
//  EndPoint.swift
//  MyPosts
//
//  Created by Sai Pratap Koppolu on 11/09/23.
//

import Foundation

struct Endpoint {
    let path: String
}

extension Endpoint {
    static var fetchPosts: Endpoint {
        Endpoint(path: "/posts")
    }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "jsonplaceholder.typicode.com"
        components.path = path
        
        return components.url
    }
}
