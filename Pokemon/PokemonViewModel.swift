//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by İrem Sever on 25.10.2025.
//

import Foundation
import Combine

@MainActor
final class PokemonViewModel: ObservableObject {
    @Published var pokemonModel: [PokemonEntry] = []
    @Published var details: [String: PokemonSelected] = [:]
    @Published var species: [Int: PokemonSpecies] = [:]  

    func getData() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil,
                  let list = try? JSONDecoder().decode(Pokemon.self, from: data) else { return }
            DispatchQueue.main.async { self.pokemonModel = list.results }
        }.resume()
    }

    func prefetchDetail(for urlString: String) {
        if details[urlString] != nil { return }
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let det = try? JSONDecoder().decode(PokemonSelected.self, from: data) else { return }
            DispatchQueue.main.async {
                self.details[urlString] = det
                self.fetchSpeciesIfNeeded(id: det.id)
            }
        }.resume()
    }

    func fetchSpeciesIfNeeded(id: Int) {
        if species[id] != nil { return }
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(id)/") else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let spec = try? JSONDecoder().decode(PokemonSpecies.self, from: data) else { return }
            DispatchQueue.main.async { self.species[id] = spec }
        }.resume()
    }
}
