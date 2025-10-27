//
//  CharacterListViewModelTests.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 26.10.2025.
//


import XCTest
@testable import APIExplorer
import XCTest
@testable import APIExplorer

@MainActor
final class CharacterListViewModelTests: XCTestCase {

    func testRefreshLoadsFirstPage() async throws {
        // GIVEN
        let mock = APIClientMock()
        mock.payload = """
        {"info":{"count":1,"pages":1,"next":null,"prev":null},
         "results":[{"id":1,"name":"Rick Sanchez","status":"Alive","species":"Human","type":"","gender":"Male",
                     "image":"https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                     "origin":{"name":"Earth"},"location":{"name":"Citadel"}}]}
        """.data(using: .utf8)!

        let vm = CharacterListViewModel(service: CharacterService(client: mock))

        // WHEN
        vm.refresh()
        try? await Task.sleep(nanoseconds: 200_000_000) // short delay to let async finish

        // THEN
        XCTAssertEqual(vm.items.count, 1)
        XCTAssertEqual(vm.items.first?.name, "Rick Sanchez")
    }

    func testSearchDebounceSetsEmptyState() async throws {
        // GIVEN
        let mock = APIClientMock()
        mock.payload = #"{"info":{"count":0,"pages":0,"next":null,"prev":null},"results":[]}"#.data(using: .utf8)!

        let vm = CharacterListViewModel(service: CharacterService(client: mock))

        // WHEN
        vm.searchDebounced("xyzxyz")
        try? await Task.sleep(nanoseconds: 600_000_000) // debounce wait + request

        // THEN
        switch vm.state {
        case .empty:
            XCTAssertTrue(true)
        default:
            XCTFail("Expected .empty state, got \(vm.state)")
        }
    }

    func testLoadMoreAppends() async throws {
        // GIVEN: first page
        let mock = APIClientMock()
        mock.payload = """
        {"info":{"count":2,"pages":2,"next":"url","prev":null},
         "results":[{"id":1,"name":"Rick Sanchez","status":"Alive","species":"Human","type":"","gender":"Male",
                     "image":"https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                     "origin":{"name":"Earth"},"location":{"name":"Citadel"}}]}
        """.data(using: .utf8)!

        let vm = CharacterListViewModel(service: CharacterService(client: mock))
        vm.refresh()
        try? await Task.sleep(nanoseconds: 200_000_000)

        // WHEN: next page
        mock.payload = """
        {"info":{"count":2,"pages":2,"next":null,"prev":"url"},
         "results":[{"id":2,"name":"Morty Smith","status":"Alive","species":"Human","type":"","gender":"Male",
                     "image":"https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                     "origin":{"name":"Earth"},"location":{"name":"Earth"}}]}
        """.data(using: .utf8)!

        if let last = vm.items.last {
            vm.loadMoreIfNeeded(current: last)
        }

        try? await Task.sleep(nanoseconds: 300_000_000)

        // THEN
        XCTAssertEqual(vm.items.count, 2)
        XCTAssertEqual(vm.items.last?.name, "Morty Smith")
    }
}
