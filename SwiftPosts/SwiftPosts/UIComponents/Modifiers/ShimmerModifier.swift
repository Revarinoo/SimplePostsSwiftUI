//
//  ShimmerModifier.swift
//  SwiftPosts
//
//  Created by Revarino Putra on 27/09/25.
//

import SwiftUI

struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.3),
                        Color.white.opacity(0.7),
                        Color.white.opacity(0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .blendMode(.overlay)
                .mask(content)
                .rotationEffect(.degrees(30))
                .offset(x: phase)
                .animation(
                    Animation.linear(duration: 1.2)
                        .repeatForever(autoreverses: false),
                    value: phase
                )
            )
            .onAppear { phase = 300 }
    }
}

extension View {
    func shimmering() -> some View {
        self.modifier(ShimmerModifier())
    }
}

#Preview("Loading State") {
    PostListView(
        viewModel: PostListViewModel(
            service: DefaultPostService(),
            initialState: .loading))
}
