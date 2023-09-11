//
//  PostsListView.swift
//  MyPosts
//
//  Created by Sai Pratap Koppolu on 11/09/23.
//

import SwiftUI
import Combine

struct PostsListView: View {
    @ObservedObject var viewModel: PostsViewModel = PostsViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if !viewModel.error.isEmpty {
                    Text("Error: \(viewModel.error)")
                } else {
                    List(viewModel.posts) { post in
                        PostRow(post: post)
                    }
                    
                }
            }
            .navigationTitle("My Posts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showFavouritesOnly.toggle()
                        viewModel.updateView()
                    } label: {
                        Image(systemName: "heart.fill")
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
        PostsListView()
    }
}

