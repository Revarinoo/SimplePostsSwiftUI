//
//  PostListView.swift
//  SwiftPosts
//
//  Created by Revarino Putra on 27/09/25.
//

import SwiftUI

struct PostListView: View {
    @StateObject private var vm: PostListViewModel
    init(viewModel: PostListViewModel) {
        _vm = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            content
                .navigationBarTitle("Simple Posts List by Revarino", displayMode: .inline)
        }
        .task {
            if case .idle = vm.state { await vm.load() }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch vm.state {
        case .idle, .loading:
            List(0..<8, id: \.self) { _ in
                VStack(alignment: .leading, spacing: 6) {
                    Text("Placeholder Title").font(.headline)
                    Text("Longer Placeholder description text to see how long it can be")
                        .font(.subheadline)
                }
                .redacted(reason: .placeholder)
                .shimmering()
            }
        case .failed(let message):
            VStack(spacing: 16) {
                Image(systemName: "wifi.exclamationmark").font(.system(size: 48))
                Text("There's error").font(.headline)
                Text(message).multilineTextAlignment(.center).foregroundColor(.secondary)
                    .padding(.horizontal)
                Button {
                    Task { await vm.load() }
                } label: { Label("Try again", systemImage: "arrow.clockwise") }
                    .buttonStyle(.bordered)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        case .loaded(let posts):
            List(posts) { post in
                NavigationLink(destination: PostDetailView(post: post)) {
                    PostRowView(post: post)
                }
            }
            .refreshable { await vm.refresh() }
        }
    }
}

#Preview("Error State") {
    PostListView(
        viewModel: PostListViewModel(
            service: DefaultPostService(),
            initialState: .failed("Failed to load data from server.")))
}

#Preview("Loading State") {
    PostListView(
        viewModel: PostListViewModel(
            service: DefaultPostService(),
            initialState: .loading))
}

#Preview("Normal State") {
    PostListView(
        viewModel: PostListViewModel(
            service: DefaultPostService(),
            initialState: .idle))
}
