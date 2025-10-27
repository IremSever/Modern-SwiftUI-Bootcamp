//
//  FavoritesStore.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 26.10.2025.
//


import Foundation
import Combine

@MainActor
final class FavoritesStore: ObservableObject {
    @Published private(set) var ids: Set<Int> = []
    private let key = "favorites.character.ids"

    init() {
        if let arr = UserDefaults.standard.array(forKey: key) as? [Int] {
            ids = Set(arr)
        }
    }

    func toggle(_ id: Int) {
        if ids.contains(id) { ids.remove(id) } else { ids.insert(id) }
        UserDefaults.standard.set(Array(ids), forKey: key)
        objectWillChange.send()
    }

    func isFavorite(_ id: Int) -> Bool { ids.contains(id) }
}
