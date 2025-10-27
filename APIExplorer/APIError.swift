//
//  APIError.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 26.10.2025.
//


import Foundation

enum APIError: LocalizedError {
    case badURL
    case transport(Error)
    case invalidResponse(Int)
    case decoding(Error)
    case empty
}

extension APIError: Equatable {
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.badURL, .badURL),
             (.empty, .empty):
            return true
        case (.invalidResponse(let l), .invalidResponse(let r)):
            return l == r
        default:
            return false
        }
    }
}
