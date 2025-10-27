//
//  CharacterServiceTests.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 26.10.2025.
//


import XCTest
@testable import APIExplorer

final class CharacterServiceTests: XCTestCase {

    func testFetchPageDecodesOneItem() async throws {
        let mock = APIClientMock()
        mock.payload = """
        {
          "info": {"count": 826, "pages": 42, "next": "https://…/page=2", "prev": null},
          "results": [{
            "id": 1,
            "name": "Rick Sanchez",
            "status": "Alive",
            "species": "Human",
            "type": "",
            "gender": "Male",
            "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            "origin": {"name": "Earth"},
            "location": {"name": "Citadel of Ricks"}
          }]
        }
        """.data(using: .utf8)!

        let svc = CharacterService(client: mock)
        let page = try await svc.fetch(page: 1, name: nil)

        XCTAssertEqual(page.results.count, 1)
        XCTAssertEqual(page.results.first?.name, "Rick Sanchez")
        XCTAssertEqual(page.info.pages, 42)
    }

    func testFetchDetailDecodesCharacter() async throws {
        let mock = APIClientMock()
        mock.payload = """
        {
          "id": 2,
          "name": "Morty Smith",
          "status": "Alive",
          "species": "Human",
          "type": "",
          "gender": "Male",
          "image": "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
          "origin": {"name": "Earth"},
          "location": {"name": "Earth"}
        }
        """.data(using: .utf8)!

        let svc = CharacterService(client: mock)
        let dto = try await svc.fetchDetail(id: 2)

        XCTAssertEqual(dto.id, 2)
        XCTAssertEqual(dto.name, "Morty Smith")
        XCTAssertEqual(dto.species, "Human")
    }

    func testServicePropagatesHTTPError() async {
        let mock = APIClientMock()
        mock.statusCode = 404
        mock.payload = Data() // önemli değil

        let svc = CharacterService(client: mock)
        do {
            _ = try await svc.fetch(page: 99, name: "zzz")
            XCTFail("404 bekleniyordu")
        } catch let e as APIError {
            XCTAssertEqual(e, .invalidResponse(404))   // Equatable yaptıysan çalışır
        } catch {
            XCTFail("APIError değil: \(error)")
        }
    }
}