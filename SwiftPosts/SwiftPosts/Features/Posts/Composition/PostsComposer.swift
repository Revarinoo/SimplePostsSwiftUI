//
//  PostsComposer.swift
//  SwiftPosts
//
//  Created by Revarino Putra on 27/09/25.
//

import SwiftUI

enum PostsComposer {
    @MainActor
    static func make() -> some View {
        let client = URLSessionHTTPClient()
        let service = DefaultPostService(client: client)
        let vm = PostListViewModel(service: service)
        return PostListView(viewModel: vm)
    }
}
