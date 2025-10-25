//
//  PokeColor.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 25.10.2025.
//


import SwiftUI

enum PokeColor {
    static func gradient(for type: String) -> LinearGradient {
        let t = type.lowercased()
        let colors: [Color]
        switch t {
        case "fire":   colors = [Color(red:1, green:0.45, blue:0.2), Color(red:0.9, green:0.2, blue:0.15)]
        case "water":  colors = [Color(red:0.25, green:0.6, blue:1), Color(red:0.1, green:0.3, blue:0.8)]
        case "grass":  colors = [Color(red:0.2, green:0.8, blue:0.4), Color(red:0.1, green:0.6, blue:0.3)]
        case "electric": colors = [Color.yellow, Color.orange]
        case "poison": colors = [Color.purple, Color(red:0.4, green:0, blue:0.6)]
        case "bug":    colors = [Color.green, Color.teal]
        case "ground": colors = [Color.brown, Color.orange]
        case "psychic": colors = [Color.pink, Color.red]
        case "rock":   colors = [Color.gray, Color.brown]
        case "fairy":  colors = [Color.pink, Color.mint]
        case "dragon": colors = [Color.indigo, Color.purple]
        case "ice":    colors = [Color.cyan, Color.blue]
        default:       colors = [Color.gray.opacity(0.7), Color.gray]
        }
        return LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}