//
//  CharacterService.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 26.10.2025.
//

import Foundation

protocol CharacterServiceProtocol {
    func fetch(page: Int, name: String?) async throws -> RMPage<CharacterDTO>
    func fetchDetail(id: Int) async throws -> CharacterDTO
}

struct CharacterService: CharacterServiceProtocol {
    private let base = "https://rickandmortyapi.com/api"
    private let client: APIClientProtocol
    init(client: APIClientProtocol = APIClient()) { self.client = client }

    func fetch(page: Int, name: String?) async throws -> RMPage<CharacterDTO> {
        var comps = URLComponents(string: "\(base)/character")!
        var q: [URLQueryItem] = [.init(name: "page", value: "\(page)")]
        if let name, !name.isEmpty { q.append(.init(name: "name", value: name)) }
        comps.queryItems = q
        guard let url = comps.url else { throw APIError.badURL }
        return try await client.get(url)
    }

    func fetchDetail(id: Int) async throws -> CharacterDTO {
        guard let url = URL(string: "\(base)/character/\(id)") else { throw APIError.badURL }
        return try await client.get(url)
    }
}

extension CharacterService {
    func fetchMany(ids: [Int]) async throws -> [CharacterDTO] {
        guard !ids.isEmpty else { return [] }
        let joined = ids.map(String.init).joined(separator: ",")
        guard let url = URL(string: "\(base)/character/\(joined)") else { throw APIError.badURL }

        do {
            return try await client.get(url) as [CharacterDTO]
        } catch {
            let single: CharacterDTO = try await client.get(url)
            return [single]
        }
    }
}
