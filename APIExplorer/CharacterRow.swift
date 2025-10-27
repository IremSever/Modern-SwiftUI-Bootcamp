//
//  CharacterRow.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 26.10.2025.
//


import SwiftUI

struct CharacterRow: View {
    let item: CharacterDTO
    @StateObject private var loader = ImageLoader()

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16).fill(gradient(for: item))

            VStack(spacing: 8) {
                Group {
                    if let image = loader.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 100)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 16))  
                    } else {
                        ProgressView()
                            .frame(height: 100)
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity, alignment: .center)

                Text(item.name)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .frame(maxWidth: .infinity, alignment: .center)

                HStack(spacing: 8) {
                    CapsuleLabel(text: item.status)
                    CapsuleLabel(text: item.species)
                }
            }
            .padding(12)
        }
        .onAppear { loader.load(from: URL(string: item.image)) }
        .frame(height: 180)
    }

    private func gradient(for item: CharacterDTO) -> LinearGradient {
        let alive = item.status.lowercased() == "alive"
        return LinearGradient(colors: alive ? [.green.opacity(0.8), .teal] : [.red.opacity(0.8), .orange],
                              startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct CapsuleLabel: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10).padding(.vertical, 6)
            .foregroundStyle(.white)
            .background(.white.opacity(0.18), in: Capsule())
            .lineLimit(1)
    }
}
