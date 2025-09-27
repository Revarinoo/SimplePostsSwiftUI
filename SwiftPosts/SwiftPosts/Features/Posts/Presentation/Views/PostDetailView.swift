//
//  PostDetailView.swift
//  SwiftPosts
//
//  Created by Revarino Putra on 27/09/25.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(post.title.capitalized)
                    .font(.title)
                    .bold()
                Text(post.body)
                    .font(.body)
                    .multilineTextAlignment(.leading)
            }
            .padding()
        }
        .navigationBarTitle("Detail", displayMode: .inline)
    }
}
