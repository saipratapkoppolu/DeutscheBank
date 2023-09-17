//
//  PostRowViewModel.swift
//  MyPosts
//
//  Created by Sai Pratap Koppolu on 16/09/23.
//

import Foundation

class PostRowViewModel: ObservableObject {
    @Published var post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    var title: String {
        post.title
    }
    
    var content: String {
        post.content
    }
    
    var favouriteImageName: String {
        post.isFavourite ? "heart.fill" : "heart"
    }
    
    func toggleFavourite() {
        post.isFavourite.toggle()
        if post.isFavourite {
            saveFavourites(post: post)
        } else {
            removeFromFavourites()
        }
    }
    
    func saveFavourites(post: Post) {
        var favourites: [Post] = fetchFavourites()
        favourites.append(post)
        
        UserDefaults.standard.encodeAndSave(object: favourites)
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
    
    func removeFromFavourites() {
        var favourites: [Post] = fetchFavourites()
        let index = favourites.firstIndex(where: { $0.id == post.id })
        guard let index = index else { return }
        favourites.remove(at: index)
        
        UserDefaults.standard.encodeAndSave(object: favourites)
    }
}

extension UserDefaults {
    func encodeAndSave<T: Encodable>(object: T) {
        do {
            let encodedData = try JSONEncoder().encode(object)
            UserDefaults.standard.set(encodedData, forKey: "favourites")
        } catch {
            print("saving error")
        }
    }
}
