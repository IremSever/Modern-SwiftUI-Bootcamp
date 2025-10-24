//
//  EmptyPlaceholder.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 24.10.2025.
//
import SwiftUI
import CoreData

struct EmptyPlaceholder: View {
    @Binding var showComposer: Bool
    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "tray")
                .font(.system(size: 48, weight: .bold))
                .foregroundStyle(.secondary)
            Text("No notes yet").font(.title3).bold()
            Text("You can add a new note with the + button at the top right.")
                .foregroundStyle(.secondary)
            Button {
                showComposer = true
            } label: {
                Label("New Note", systemImage: "plus")
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(.thinMaterial, in: Capsule())
            }
        }
        .padding()
    }
}
