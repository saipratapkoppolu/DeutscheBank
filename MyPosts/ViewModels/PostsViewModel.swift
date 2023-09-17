//
//  PostsViewModel.swift
//  MyPosts
//
//  Created by Sai Pratap Koppolu on 11/09/23.
//

import Foundation
import Combine

enum FetchError: Error {
    case unableToFetch
}

class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var error: String = ""
    
    @Published var showFavouritesOnly: Bool = false
    
    private let apiService = APIService()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var showLoader: Bool = false
    
    var favouriteImageName: String {
        showFavouritesOnly ? "heart.fill" : "heart"
    }
    
    var filteredPosts: [Post] {
        if showFavouritesOnly {
            return posts.filter(\.isFavourite)
        }
        return posts
    }
    
    func toggleFavorite(post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts[index].isFavourite.toggle()
        }
    }
    
    func fetchData(for endpoint: Endpoint) {
        showLoader = true
        do {
            try apiService.fetchPosts(endpoint: endpoint)
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { completion in
                        self.showLoader = false
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            self.error = error.localizedDescription
                        }
                    }, receiveValue: { posts in
                        self.posts = posts
                        self.setFavourites()
                    }
                )
                .store(in: &cancellables)
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func setFavourites() {
        let favourites = self.fetchFavourites()
        favourites.forEach({ favouritePost in
            let index = self.posts.firstIndex { post in
                post.id == favouritePost.id
            }
            guard let index = index else { return }
            self.toggleFavorite(post: self.posts[index])
        })
    }
    
    func fetchFavourites() -> [Post] {
        if let favouritesData = UserDefaults.standard.data(forKey: "favourites") {
            do {
                return try JSONDecoder().decode([Post].self, from: favouritesData)
            } catch {
                
            }
        }
        return []
    }
}
