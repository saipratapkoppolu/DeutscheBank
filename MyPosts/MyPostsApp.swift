//
//  MyPostsApp.swift
//  MyPosts
//
//  Created by Sai Pratap Koppolu on 11/09/23.
//

import SwiftUI

@main
struct MyPostsApp: App {
    @StateObject private var viewModel = PostsViewModel()
    
    var body: some Scene {
        WindowGroup {
            PostsListView(viewModel: viewModel)
        }
    }
}
