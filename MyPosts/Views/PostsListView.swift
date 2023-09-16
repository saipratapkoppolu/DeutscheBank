//
//  PostsListView.swift
//  MyPosts
//
//  Created by Sai Pratap Koppolu on 11/09/23.
//

import SwiftUI
import Combine

struct PostsListView: View {
    @ObservedObject var viewModel: PostsViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.showLoader {
                    ProgressView()
                } else {
                    if !viewModel.error.isEmpty {
                        Text("Error: \(viewModel.error)")
                    } else {
                        List(viewModel.filteredPosts) { post in
                            PostRow(viewModel: PostRowViewModel(post: post)) { post in
                                viewModel.toggleFavorite(post: post)
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("My Posts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showFavouritesOnly.toggle()
                    } label: {
                        Image(
                            systemName:
                                viewModel.favouriteImageName
                        )
                        .tint(.red)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchData(for: .fetchPosts)
        }
        
    }
}

struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        PostsListView(viewModel: PostsViewModel())
    }
}

