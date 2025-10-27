//
//  APIClientProtocol.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 26.10.2025.
//


import Foundation
import Combine

protocol APIClientProtocol {
    func get<T: Decodable>(_ url: URL) async throws -> T
}

struct APIClient: APIClientProtocol {
    func get<T: Decodable>(_ url: URL) async throws -> T {
        var req = URLRequest(url: url)
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        do {
            let (data, resp) = try await URLSession.shared.data(for: req)
            guard let http = resp as? HTTPURLResponse else { throw APIError.empty }
            guard (200...299).contains(http.statusCode) else { throw APIError.invalidResponse(http.statusCode) }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(T.self, from: data)
            } catch { throw APIError.decoding(error) }
        } catch { throw APIError.transport(error) }
    }
}
