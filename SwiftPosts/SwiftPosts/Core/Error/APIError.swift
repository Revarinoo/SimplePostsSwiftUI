//
//  APIError.swift
//  SwiftPosts
//
//  Created by Revarino Putra on 27/09/25.
//

import Foundation

enum APIError: LocalizedError, Equatable {
    case invalidURL
    case requestFailed(underlying: Error)
    case badStatus(code: Int)
    case decodingFailed(underlying: Error)
    case emptyData
    case timeout
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
            (.emptyData, .emptyData),
            (.timeout, .timeout),(.requestFailed, .requestFailed),
            (.decodingFailed, .decodingFailed):
            return true
        case (.badStatus(let l), .badStatus(let r)):
            return l == r
        default:
            return false
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .requestFailed(let error): return "Network request failed: \(error.localizedDescription)"
        case .badStatus(let code): return "Server return bad status (\(code))."
        case .decodingFailed(let error): return "Failed processing data: \(error.localizedDescription)"
        case .emptyData: return "Empty data."
        case .timeout: return "Request timeout."
        }
    }
}
