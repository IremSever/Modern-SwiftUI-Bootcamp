//
//  NoteRowCard.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 24.10.2025.
//

import SwiftUI
import CoreData

struct NoteRowCard: View {
    let title: String
    let date: Date
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle().fill(.purple.gradient)
                    .frame(width: 54, height: 54)
                    .overlay(Circle().strokeBorder(.white.opacity(0.35), lineWidth: 1))
                    .shadow(radius: 6, y: 3)
                Image(systemName: "note.text")
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(title).font(.headline).lineLimit(1)
                Label(date.formatted(date: .abbreviated, time: .shortened), systemImage: "clock")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(16)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(.white.opacity(0.25), lineWidth: 1))
    }
}
