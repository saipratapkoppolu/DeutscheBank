//
//  APIService.swift
//  MyPosts
//
//  Created by Sai Pratap Koppolu on 11/09/23.
//

import Foundation
import Combine

class APIService {
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchPosts(endpoint: Endpoint) -> AnyPublisher<[Post], Error> {
//        guard let url = endpoint.url else {
//
//            return
//        }
        
        URLSession.shared.dataTaskPublisher(for: endpoint.url!)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
}
