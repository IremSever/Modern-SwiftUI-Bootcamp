//
//  PokemonSelected.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 25.10.2025.
//

import Foundation

struct PokemonSelected: Codable {
    let id: Int
    let sprites: PokemonSprites
    let weight: Int
    let types: [TypeSlot]

    struct TypeSlot: Codable {
        let slot: Int
        let type: Named
        struct Named: Codable { let name: String }
    }
}

struct PokemonSprites: Codable { let front_default: String? }

struct PokemonSpecies: Codable {
    let flavor_text_entries: [Flavor]
    struct Flavor: Codable {
        let flavor_text: String
        let language: Lang
        struct Lang: Codable { let name: String }
    }
}
