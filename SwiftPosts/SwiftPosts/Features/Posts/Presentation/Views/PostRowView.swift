//
//  PostRowView.swift
//  SwiftPosts
//
//  Created by Revarino Putra on 27/09/25.
//

import SwiftUI

struct PostRowView: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(post.title.capitalized)
                .font(.headline)
                .lineLimit(2)
            Text(post.body)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
}

#Preview {
    PostRowView(post: Post(id: 1, title: "Title", body: "Content"))
}
