//
//  CharacterDetailView.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 26.10.2025.
//


import SwiftUI
struct CharacterDetailView: View {
    @StateObject private var vm: CharacterDetailViewModel
    @Environment(\.dismiss) private var dismiss

    init(id: Int) { _vm = StateObject(wrappedValue: CharacterDetailViewModel(id: id)) }

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            switch vm.state {
            case .loading:
                ProgressView()
            case .error(let msg):
                ContentUnavailableView("Failed to load", systemImage: "xmark.octagon", description: Text(msg)) // Yüklenemedi
            case .loaded(let item):
                ScrollView {
                    VStack(spacing: 16) {

                        ZStack(alignment: .bottom) {
                            AsyncImage(url: URL(string: item.image)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView().frame(height: 320)
                                case .success(let img):
                                    img.resizable()
                                        .scaledToFill()
                                        .frame(height: 320)
                                        .frame(maxWidth: .infinity)
                                        .clipped()
                                case .failure:
                                    Image(systemName: "photo").resizable().scaledToFit()
                                        .frame(height: 220).foregroundStyle(.white.opacity(0.6))
                                @unknown default: EmptyView()
                                }
                            }

                            LinearGradient(colors: [.white.opacity(0.0), .black.opacity(0.7)],
                                           startPoint: .top, endPoint: .bottom)
                            .frame(height: 120)
                            
                            HStack(alignment: .bottom) {
                                VStack(alignment: .leading, spacing: 8) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(item.name.uppercased())
                                            .font(.system(size: 28, weight: .heavy))
                                            .foregroundStyle(.white)
                                            .accessibilityIdentifier("detailTitle")
                                    }
                                }
                                Spacer()
                                Text(item.status)
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(.white.opacity(0.9))
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 12)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        .overlay(alignment: .topLeading) {
                            Button { dismiss() } label: {
                                Image(systemName: "chevron.left")
                                    .font(.title2.weight(.semibold))
                                    .foregroundStyle(.white)
                                    .frame(width: 36, height: 36)
                                    .background(.black.opacity(0.35), in: Circle())
                            }
                            .padding(.leading, 20)
                            .padding(.top, 16)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("About")
                                .font(.headline)
                            Text("I'm professional snowboarder, global traveler, photographer, adventurer.")
                                .foregroundStyle(.secondary)
                            Text("Origin: \(item.origin.name)")
                                .foregroundStyle(.secondary)
                            Text("Last seen: \(item.location.name)")
                                .foregroundStyle(.secondary)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.orange.opacity(0.2), in: RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 16)
                        Spacer(minLength: 24)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
