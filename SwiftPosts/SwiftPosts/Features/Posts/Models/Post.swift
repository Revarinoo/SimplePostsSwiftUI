//
//  Post.swift
//  SwiftPosts
//
//  Created by Revarino Putra on 27/09/25.
//

import Foundation

struct Post: Identifiable, Decodable, Equatable {
    let id: Int
    let title: String
    let body: String
}
