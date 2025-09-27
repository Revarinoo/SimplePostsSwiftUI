//
//  SwiftPostsApp.swift
//  SwiftPosts
//
//  Created by Revarino Putra on 27/09/25.
//

import SwiftUI

@main
struct SwiftPostsApp: App {
    var body: some Scene {
        WindowGroup {
            PostsComposer.make()
        }
    }
}
