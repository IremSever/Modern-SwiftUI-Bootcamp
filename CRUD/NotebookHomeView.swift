//
//  NotebookHomeView.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 24.10.2025.
//

import SwiftUI
import CoreData

struct NotebookHomeView: View {
    @Environment(\.managedObjectContext) private var ctx
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.date, ascending: false)],
        animation: .default
    ) private var notes: FetchedResults<Note>

    @State private var query = ""
    @State private var showComposer = false

    private var filtered: [Note] {
        guard !query.isEmpty else { return Array(notes) }
        return notes.filter { $0.title!.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(.sRGB, red: 1.0,   green: 0.985, blue: 0.965, opacity: 1),
                        Color(.sRGB, red: 0.970, green: 0.975, blue: 1.000, opacity: 1)
                    ],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
                .overlay(LinearGradient(colors: [.purple.opacity(0.05), .mint.opacity(0.05)],
                                        startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()

                VStack(spacing: 16) {
                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Notes").font(UIStyles.titleXL)
                            Text("List • Compose • Edit")
                                .font(UIStyles.sub).foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button { showComposer = true } label: {
                            Image(systemName: "square.and.pencil")
                                .font(.title3)
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: UIStyles.radius).fill(.thinMaterial))
                                .overlay(RoundedRectangle(cornerRadius: UIStyles.radius).stroke(.white.opacity(0.25), lineWidth: 1))
                        }
                        .accessibilityLabel("New Note")
                    }
                    .padding(14)
                    .padding(.horizontal)
                    .notebookCard()

                    HStack(spacing: 10) {
                        QueryField(text: $query)
                        Button("Find notes") { }
                            .font(UIStyles.body)
                            .padding(.horizontal, 12).padding(.vertical, 10)
                            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(.white.opacity(0.25), lineWidth: 1))
                    }
                    .padding(.horizontal)
                    .notebookCard()

                    if filtered.isEmpty {
                        EmptyPlaceholder(showComposer: $showComposer)
                            .padding(.horizontal)
                            .notebookCard()
                    } else {
                        List {
                            ForEach(filtered) { note in
                                NavigationLink {
                                    NoteEditorSheet(note: note)
                                } label: {
                                    NoteRowCard(title: note.title ?? "", date: note.date!)
                                        .listRowInsets(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
                                }
                                .listRowBackground(Color.clear)
                            }
                            .onDelete { idx in
                                idx.map { filtered[$0] }.forEach(ctx.delete)
                                try? ctx.save()
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .sheet(isPresented: $showComposer) {
                ComposeNoteSheet()
                    .presentationDetents([.medium, .large])
                    .presentationCornerRadius(UIStyles.radius)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationTitle("Notes")

    }
}
