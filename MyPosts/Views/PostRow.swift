//
//  PostRow.swift
//  MyPosts
//
//  Created by Sai Pratap Koppolu on 11/09/23.
//

import SwiftUI

struct PostRow: View {
    @State var post: Post
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(post.title)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(post.content)
                    .font(.caption)
            }
            Spacer()
            Button {
                post.isFavourite.toggle()
            } label: {
                Image(systemName: post.isFavourite ? "heart.fill" : "heart")
            }
            .tint(.red)

            
        }
        .padding(.all, 20)
        
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(post: Post.previewData)
    }
}
