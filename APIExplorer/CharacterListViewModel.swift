//
//  CharacterListViewModel.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 26.10.2025.
//


import Foundation
import Combine

@MainActor
final class CharacterListViewModel: ObservableObject {
    enum State { case idle, loading, loaded, error(String), empty }
    @Published private(set) var state: State = .idle
    @Published private(set) var items: [CharacterDTO] = []
    @Published var query: String = ""

    private let service: CharacterServiceProtocol
    private var page = 1
    private var canLoadMore = true
    private var loadingTask: Task<Void, Never>?

    init(service: CharacterServiceProtocol = CharacterService()) {
        self.service = service
    }

    func refresh() {
        page = 1; canLoadMore = true; items.removeAll()
        load(reset: true)
    }

    func loadMoreIfNeeded(current item: CharacterDTO) {
        guard canLoadMore else { return }
        if case .loading = state { return }
        if items.last?.id == item.id { page += 1; load() }
    }

    func searchDebounced(_ text: String) {
        query = text
        loadingTask?.cancel()
        loadingTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 500_000_000)
            await self?.refresh()
        }
    }

    func load(reset: Bool = false) {
        state = reset ? .loading : state
        Task {
            do {enum State: Equatable { case idle, loading, loaded, error(String), empty }

                let pageResp = try await service.fetch(page: page, name: query.isEmpty ? nil : query)
                canLoadMore = pageResp.info.next != nil
                if reset && pageResp.results.isEmpty { state = .empty; return }
                items.append(contentsOf: pageResp.results)
                state = .loaded
            } catch let e as APIError {
                state = .error(e.localizedDescription)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
