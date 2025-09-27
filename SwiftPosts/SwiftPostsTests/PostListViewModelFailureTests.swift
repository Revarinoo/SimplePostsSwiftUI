//
//  PostListViewModelFailureTests.swift
//  SwiftPostsTests
//
//  Created by Revarino Putra on 27/09/25.
//

import XCTest
@testable import SwiftPosts

struct MockPostService_Failure: PostService {
    enum DummyError: LocalizedError { case failed }
    func fetchPosts() async throws -> [Post] { throw DummyError.failed }
}

@MainActor
final class PostListViewModelFailureTests: XCTestCase {

    func test_load_shouldSetStateFailed_whenServiceThrows() async {
        let sut = PostListViewModel(service: MockPostService_Failure())
        await sut.load()

        if case .failed(let message) = sut.state {
            XCTAssertFalse(message.isEmpty, "Error message should not be empty")
        } else {
            XCTFail("Expected state .failed, got \(sut.state)")
        }
    }
}
