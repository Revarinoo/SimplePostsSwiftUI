//
//  PostListViewModelTests.swift
//  SwiftPostsTests
//
//  Created by Revarino Putra on 27/09/25.
//

import XCTest
@testable import SwiftPosts

struct MockPostService_Success: PostService {
    let posts: [Post]
    func fetchPosts() async throws -> [Post] { posts }
}

@MainActor
final class PostListViewModelTests: XCTestCase {

    func test_load_shouldSetStateLoaded_whenServiceReturnsPosts() async {
        
        let dummy = [
            Post(id: 1, title: "A", body: "a"),
            Post(id: 2, title: "B", body: "b")
        ]
        let service = MockPostService_Success(posts: dummy)
        let sut = PostListViewModel(service: service)

        XCTAssertEqual(sut.state, .idle)

        await sut.load()

        if case let .loaded(posts) = sut.state {
            XCTAssertEqual(posts, dummy)
        } else {
            XCTFail("Expected state .loaded, got \(sut.state)")
        }
    }
}
