//
//  PostService.swift
//  SwiftPosts
//
//  Created by Revarino Putra on 27/09/25.
//

import Foundation

protocol PostService {
    func fetchPosts() async throws -> [Post]
}

struct DefaultPostService: PostService {
    private let client: HTTPClient
    init(client: HTTPClient = URLSessionHTTPClient()) { self.client = client }

    func fetchPosts() async throws -> [Post] {
        try await client.get(Endpoint.baseURL + Endpoint.Posts.all)
    }
}
