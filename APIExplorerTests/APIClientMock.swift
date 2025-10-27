//
//  APIClientMock.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 26.10.2025.
//


import Foundation
@testable import APIExplorer

final class APIClientMock: APIClientProtocol {
    var payload: Data?
    var statusCode: Int = 200

    func get<T: Decodable>(_ url: URL) async throws -> T {
        guard statusCode == 200, let payload else { throw APIError.invalidResponse(statusCode) }
        let dec = JSONDecoder()
        dec.keyDecodingStrategy = .convertFromSnakeCase
        return try dec.decode(T.self, from: payload)
    }
}