//
//  PostsViewModel.swift
//  MyPosts
//
//  Created by Sai Pratap Koppolu on 11/09/23.
//

import Foundation
import Combine

class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var error: String = ""
    
    var showFavouritesOnly: Bool = false
    var favouritePosts: [Post] {
        posts.filter(\.isFavourite)
    }
    
    private let apiService = APIService()
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchData(for endpoint: Endpoint) {
        apiService.fetchPosts(endpoint: endpoint)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            }, receiveValue: { posts in
                self.posts = posts
            })
            .store(in: &cancellables)
    }
    
    func updateView() {
        if showFavouritesOnly {
            self.posts = favouritePosts
            return
        }
        fetchData(for: .fetchPosts)
    }
}
