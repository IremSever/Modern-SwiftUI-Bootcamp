//
//  PokemonBigCard.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 25.10.2025.
//

import SwiftUI
import SwiftUI

struct PokemonBigCard: View {
    let entry: PokemonEntry
    let detail: PokemonSelected?
    var onAppear: () -> Void = {}
    var imageSize: CGFloat = 50

    private var spriteURL: URL? {
        if let s = detail?.sprites.front_default { return URL(string: s) }
        let id = entry.url.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
            .split(separator: "/").last.map(String.init) ?? ""
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
    }

    private var primaryType: String {
        detail?.types.sorted(by: { $0.slot < $1.slot }).first?.type.name.capitalized ?? "Unknown"
    }

    var body: some View {
        NavigationLink {
            PokemonDetailView(entry: entry, detail: detail)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(PokeColor.gradient(for: primaryType))
                    .shadow(color: .black.opacity(0.12), radius: 6, x: 0, y: 4)

                VStack(spacing: 8) {
                    AsyncImage(url: spriteURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView().frame(width: imageSize, height: imageSize)
                        case .success(let img):
                            img.resizable()
                                .scaledToFit()
                                .frame(width: imageSize, height: imageSize)
                                .shadow(radius: 4)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable().scaledToFit()
                                .frame(width: imageSize, height: imageSize)
                                .foregroundStyle(.white.opacity(0.7))
                        @unknown default: EmptyView()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    Text(entry.name.capitalized)
                        .font(.headline.weight(.bold))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .frame(maxWidth: .infinity)

                    HStack(spacing: 6) {
                        CapsuleBadge(icon: iconName(for: primaryType), text: primaryType)

                        if let w = detail?.weight {
                            CapsuleBadge(icon: "scalemass", text: "Wt \(w)")
                        }
                    }
                    .padding(.top, 2)
                }
                .padding(12)
            }
            .frame(height: 100)
            .onAppear(perform: onAppear)
        }
        .buttonStyle(.plain)
    }

    private func iconName(for type: String) -> String {
        switch type.lowercased() {
        case "fire": return "flame.fill"
        case "water": return "drop.fill"
        case "grass": return "leaf.fill"
        case "electric": return "bolt.fill"
        case "psychic": return "sparkles"
        case "ice": return "snowflake"
        case "rock": return "circle.lefthalf.filled"
        case "ground": return "globe.americas.fill"
        case "dragon": return "bolt.horizontal.fill"
        case "fairy": return "wand.and.stars"
        default: return "circle.fill"
        }
    }
}

