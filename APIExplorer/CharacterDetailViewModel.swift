//
//  CharacterDetailViewModel.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 26.10.2025.
//


import Foundation
import Combine

@MainActor
final class CharacterDetailViewModel: ObservableObject {
    enum State { case loading, loaded(CharacterDTO), error(String) }
    @Published private(set) var state: State = .loading
    private let service: CharacterServiceProtocol
    private let id: Int

    init(id: Int, service: CharacterServiceProtocol = CharacterService()) {
        self.id = id; self.service = service
        Task { await load() }
    }

    func load() async {
        do {
            let dto = try await service.fetchDetail(id: id)
            state = .loaded(dto)
        } catch let e as APIError {
            state = .error(e.localizedDescription)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
