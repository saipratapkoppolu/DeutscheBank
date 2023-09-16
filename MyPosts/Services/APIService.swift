//
//  APIService.swift
//  MyPosts
//
//  Created by Sai Pratap Koppolu on 11/09/23.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidURL
}

class APIService {
    func fetchPosts(endpoint: Endpoint) throws -> AnyPublisher<[Post], Error> {
        guard let url = endpoint.url else {
            throw APIError.invalidURL
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
