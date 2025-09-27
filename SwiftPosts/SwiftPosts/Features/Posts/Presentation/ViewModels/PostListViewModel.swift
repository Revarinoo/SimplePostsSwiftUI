//
//  PostListViewModel.swift
//  SwiftPosts
//
//  Created by Revarino Putra on 27/09/25.
//

import Foundation
import Combine

@MainActor
final class PostListViewModel: ObservableObject {
    enum State: Equatable {
        case idle
        case loading
        case loaded([Post])
        case failed(String)
    }
    
    @Published private(set) var state: State = .idle
    private let service: PostService
    
    init(service: PostService, initialState: State = .idle) {
        self.service = service
        self.state = initialState
    }
    
    func load() async {
        state = .loading
        await refresh()
    }
    
    func refresh() async {
        do {
            let posts = try await service.fetchPosts()
            state = .loaded(posts)
        } catch {
            let message = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
            state = .failed(message)
        }
    }
}
