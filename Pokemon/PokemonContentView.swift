//
//  PokemonContentView.swift
//  Pokemon
//
//  Created by İrem Sever on 25.10.2025.
//

import SwiftUI

struct PokemonContentView: View {
    @StateObject private var vm = PokemonViewModel()
       @State private var searchText = ""
       @State private var scrollY: CGFloat = 0

       var body: some View {
           NavigationStack {
               ZStack {
                   LinearGradient(colors: [Color.black, Color(.sRGB, red: 25/255, green: 20/255, blue: 20/255, opacity: 1)], startPoint: .top, endPoint: .bottom)
                       .ignoresSafeArea()

                   VStack(alignment: .leading, spacing: 16) {
                      HStack {
                           Text("Select Your")
                               .font(.title2.weight(.semibold))
                               .foregroundStyle(.white.opacity(0.8))
                           Text("Pokemon")
                               .font(.largeTitle.bold())
                               .foregroundStyle(.white)
                       }
                       .padding(.horizontal, 20)
                       .padding(.top, 8)

                       HStack(spacing: 10) {
                           Image(systemName: "magnifyingglass")
                           TextField("Search Pokémon…", text: $searchText)
                               .textInputAutocapitalization(.never)
                               .disableAutocorrection(true)
                       }
                       .padding(.horizontal, 16)
                       .padding(.vertical, 12)
                       .background(.white, in: RoundedRectangle(cornerRadius: 14))
                       .overlay(RoundedRectangle(cornerRadius: 14).stroke(.white.opacity(0.08)))
                       .padding(.horizontal, 20)

                       ScrollView {
                           LazyVGrid(
                               columns: [
                                   GridItem(.flexible(), spacing: 16),
                                   GridItem(.flexible(), spacing: 16)
                               ],
                               spacing: 16
                           ) {
                               ForEach(filtered, id: \.id) { entry in
                                   PokemonBigCard(
                                       entry: entry,
                                       detail: vm.details[entry.url],
                                       onAppear: { vm.prefetchDetail(for: entry.url) },
                                       imageSize: 80
                                   )
                                   .frame(height: 160)
                               }
                           }
                           .padding(.horizontal, 16)
                           .padding(.vertical, 20)
                       }

                       .frame(maxWidth: .infinity, maxHeight: .infinity)
                   }
               }
               .task { vm.getData() }
               .navigationBarHidden(true)
           }
       }

       @State private var currentIndex: Int = 0

       private var filtered: [PokemonEntry] {
           let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
           guard !q.isEmpty else { return vm.pokemonModel }
           return vm.pokemonModel.filter { $0.name.localizedCaseInsensitiveContains(q) }
       }

   }

#Preview {
    PokemonContentView()
}
