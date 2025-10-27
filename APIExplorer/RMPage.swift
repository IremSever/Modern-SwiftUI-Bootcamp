//
//  RMPage.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 26.10.2025.
//


import Foundation

struct RMPage<T: Decodable>: Decodable {
    let info: Info
    let results: [T]
    struct Info: Decodable { let count: Int; let pages: Int; let next: String?; let prev: String? }
}

struct CharacterDTO: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let origin: LocationRef
    let location: LocationRef
    struct LocationRef: Decodable { let name: String }
}
