//
//  HTTPClient.swift
//  SwiftPosts
//
//  Created by Revarino Putra on 27/09/25.
//

import Foundation

protocol HTTPClient {
    func get<T: Decodable>(_ urlString: String) async throws -> T
}

struct URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    init(session: URLSession = {
        let cfg = URLSessionConfiguration.ephemeral
        cfg.timeoutIntervalForRequest = 15
        cfg.timeoutIntervalForResource = 30
        return URLSession(configuration: cfg)
    }()) {
        self.session = session
    }
    
    func get<T: Decodable>(_ urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else { throw APIError.invalidURL }
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let (data, resp) = try await session.data(for: req)
            guard let http = resp as? HTTPURLResponse else {
                throw APIError.requestFailed(underlying: URLError(.badServerResponse))
            }
            guard (200...299).contains(http.statusCode) else {
                throw APIError.badStatus(code: http.statusCode)
            }
            guard !data.isEmpty else { throw APIError.emptyData }
            
            do { return try JSONDecoder().decode(T.self, from: data) }
            catch { throw APIError.decodingFailed(underlying: error) }
        } catch {
            if (error as? URLError)?.code == .timedOut { throw APIError.timeout }
            throw APIError.requestFailed(underlying: error)
        }
    }
}
