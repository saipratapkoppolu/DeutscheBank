//
//  PostRow.swift
//  MyPosts
//
//  Created by Sai Pratap Koppolu on 11/09/23.
//

import SwiftUI

struct PostRow: View {
    @State var viewModel: PostRowViewModel
    
    var handleFavouriteAction: (Post) -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.post.title)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(viewModel.post.content)
                    .font(.caption)
            }
            
            Spacer()
            
            Button {
                viewModel.toggleFavourite()
                handleFavouriteAction(viewModel.post)
            } label: {
                Image(systemName: viewModel.favouriteImageName)
            }
            .tint(.red)
        }
        .padding(.all, 20)
        
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(viewModel: PostRowViewModel(post: Post.previewData), handleFavouriteAction: { _ in })
    }
}
