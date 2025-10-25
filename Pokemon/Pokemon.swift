//
//  Pokemon.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 25.10.2025.
//


import Foundation

struct Pokemon : Codable{
    var results: [PokemonEntry]
}

struct PokemonEntry : Codable, Identifiable  {
    let id = UUID()
    var name: String
    var url: String
}
