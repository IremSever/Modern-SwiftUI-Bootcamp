//
//  FavoritesView.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 26.10.2025.
//


import SwiftUI

struct FavoritesView: View {
    @StateObject private var favs = FavoritesStore()
    @State private var items: [CharacterDTO] = []
    @State private var isLoading = false
    @State private var errorMsg: String?

    private let service = CharacterService()

    var body: some View {
        Group {
            if isLoading {
                ProgressView("Yükleniyor…")
            } else if let msg = errorMsg {
                ContentUnavailableView("Favoriler yüklenemedi", systemImage: "xmark.octagon", description: Text(msg))
            } else if items.isEmpty {
                ContentUnavailableView("Favori yok", systemImage: "heart", description: Text("Liste ekranından kalp ile ekleyin."))
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16),
                                        GridItem(.flexible(), spacing: 16)], spacing: 16) {
                        ForEach(items) { item in
                            NavigationLink {
                                CharacterDetailView(id: item.id)
                            } label: {
                                CharacterRow(item: item)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(16)
                }
            }
        }
        .navigationTitle("Favorilerim")
        .task { await load() }
        .onReceive(favs.$ids) { _ in Task { await load() } } // favoriler değişirse yenile
    }

    @MainActor
    private func load() async {
        isLoading = true; errorMsg = nil
        do {
            let list = try await service.fetchMany(ids: Array(favs.ids))
            items = list.sorted(by: { $0.name < $1.name })
            isLoading = false
        } catch {
            errorMsg = error.localizedDescription
            isLoading = false
        }
    }
}
