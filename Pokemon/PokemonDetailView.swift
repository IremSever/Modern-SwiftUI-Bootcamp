//
//  PokemonDetailView.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 25.10.2025.
//

import SwiftUI

struct PokemonDetailView: View {
    let entry: PokemonEntry
    let detail: PokemonSelected?

    @Environment(\.dismiss) private var dismiss
    @State private var flavor: String = ""

    private var spriteURL: URL? {
        if let s = detail?.sprites.front_default { return URL(string: s) }
        let id = entry.url.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
            .split(separator: "/").last.map(String.init) ?? ""
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }

    private var primaryType: String {
        detail?.types.sorted(by: { $0.slot < $1.slot }).first?.type.name.capitalized ?? "Unknown"
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.black, Color(.sRGB, red: 25/255, green: 20/255, blue: 20/255, opacity: 1)],
                           startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()

            VStack(spacing: 20) {
                AsyncImage(url: spriteURL) { phase in
                    switch phase {
                    case .empty: ProgressView().frame(height: 260)
                    case .success(let img): img.resizable().scaledToFit().frame(height: 280).shadow(radius: 20)
                    case .failure: Image(systemName: "photo").resizable().scaledToFit().frame(height: 200).foregroundStyle(.white.opacity(0.6))
                    @unknown default: EmptyView()
                    }
                }
                .padding(.top, 10)

                VStack(spacing: 10) {
                    Text(entry.name.capitalized)
                        .font(.system(size: 36, weight: .bold))
                        .foregroundStyle(.white)

                    HStack(spacing: 8) {
                        Label(primaryType, systemImage: "flame.fill")
                            .font(.caption.weight(.semibold))
                            .padding(.horizontal, 12).padding(.vertical, 6)
                            .background(.white.opacity(0.15), in: Capsule())
                            .foregroundStyle(.white)
                    }

                    Text(flavor.isEmpty ? "Loading description…" : flavor)
                        .font(.callout)
                        .foregroundStyle(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .frame(maxWidth: 520)
                }
            }
        }
        .overlay(alignment: .topLeading) {
            Button { dismiss() } label: {
                Image(systemName: "chevron.left")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.white)
                    .frame(width: 36, height: 36)
                    .background(.white.opacity(0.15), in: Circle())
            }
            .padding(.leading, 16)
            .padding(.top, 16)    
        }
        .navigationBarBackButtonHidden(true)
        .task { await loadFlavor() }
    }

    private func idFromURL() -> Int? {
        Int(entry.url.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
            .split(separator: "/").last.map(String.init) ?? "")
    }

    private func loadFlavor() async {
        guard let id = idFromURL(),
              let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(id)/") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let spec = try JSONDecoder().decode(PokemonSpecies.self, from: data)
            if let en = spec.flavor_text_entries.first(where: { $0.language.name == "en" })?.flavor_text {
                flavor = en.replacingOccurrences(of: "\n", with: " ").replacingOccurrences(of: "\u{0C}", with: " ")
            }
        } catch { }
    }
}
