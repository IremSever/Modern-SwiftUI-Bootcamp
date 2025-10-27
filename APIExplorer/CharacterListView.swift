//
//  CharacterListView.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 26.10.2025.
//

import SwiftUI
import Combine

struct CharacterListView: View {
    @StateObject private var vm = CharacterListViewModel()
    @StateObject private var favs = FavoritesStore()
    @State private var searchText: String = ""

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationStack {

            Group {
                switch vm.state {
                case .idle, .loading:
                    ProgressView("Loading…")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .empty:
                    ContentUnavailableView("No results", systemImage: "magnifyingglass",
                                           description: Text("Change your search."))
                case .error(let msg):
                    VStack(spacing: 12) {
                        Text("An error occurred").font(.headline)
                        Text(msg).foregroundStyle(.secondary)
                        Button("Try Again") { vm.refresh() }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .loaded:
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(vm.items) { item in
                                NavigationLink {
                                    CharacterDetailView(id: item.id)
                                } label: {
                                    ZStack(alignment: .topTrailing) {
                                        CharacterRow(item: item)
                                        Button {
                                            favs.toggle(item.id)
                                        } label: {
                                            Image(systemName: favs.isFavorite(item.id) ? "heart.fill" : "heart")
                                                .foregroundStyle(.purple)
                                                .padding(16)
                                        }
                                    }
                                }
                                .buttonStyle(.plain)
                                .task { vm.loadMoreIfNeeded(current: item) }
                            }
                        }
                        .padding(16)
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .safeAreaInset(edge: .top) {
                VStack(spacing: 10) {
                    HStack {
                        Text("API Explorer")
                            .font(.largeTitle.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)

                        NavigationLink {
                            FavoritesView()
                        } label: {
                            Image(systemName: "heart.fill")
                                .font(.title2.weight(.semibold))
                                .foregroundStyle(.purple)
                                .frame(width: 40, height: 40)
                                .background(.black.opacity(0.18), in: Circle())
                        }
                    }

                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                        TextField("Search by name…", text: $searchText)
                            .accessibilityIdentifier("searchField")
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .onChange(of: searchText) { vm.searchDebounced($0) }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(.white.opacity(0.08)))
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .background(.clear)
            }
            .refreshable { vm.refresh() }
            .task { vm.refresh() }
        }
    }
}
