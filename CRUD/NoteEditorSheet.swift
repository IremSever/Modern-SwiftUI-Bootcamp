//
//  NoteEditorSheet.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 24.10.2025.
//
import SwiftUI
import CoreData

struct NoteEditorSheet: View {
    @Environment(\.managedObjectContext) private var ctx
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var note: Note
    @State private var confirmDelete = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(.sRGB, red: 1.0,   green: 0.985, blue: 0.965, opacity: 1),
                    Color(.sRGB, red: 0.970, green: 0.975, blue: 1.000, opacity: 1)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 14) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Information")
                        .font(UIStyles.title)

                    HStack(spacing: 10) {
                        Image(systemName: "text.cursor")
                            .foregroundStyle(.secondary)
                        TextField("Title", text: Binding(
                            get: { note.title ?? "" },
                            set: { note.title = $0 }
                        ))
                        .font(UIStyles.body)
                        .lineLimit(1)
                        .minimumScaleFactor(0.9)
                    }
                    .padding(12)
                    .notebookField()

                    DatePicker("Date", selection: Binding(
                        get: { note.date ?? Date() },
                        set: { note.date = $0 }
                    ), displayedComponents: [.date, .hourAndMinute])
                    .padding(12)
                    .notebookField()

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Content")
                            .font(UIStyles.sub)
                            .foregroundStyle(.secondary)
                        TextEditor(text: Binding(
                            get: { note.content ?? "" },
                            set: { note.content = $0 }
                        ))
                        .frame(minHeight: 160)
                        .padding(8)
                        .notebookField()
                    }
                }
                .padding(16)
                .notebookCard()

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 12) {
                Button(role: .destructive) {
                    confirmDelete = true
                } label: {
                    Text("Delete")
                        .font(UIStyles.body)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: UIStyles.radius)
                                .fill(Color.red.opacity(0.12))
                        )
                }
                .foregroundStyle(.red)

                Button {
                    do {
                        try ctx.save()
                        dismiss()
                    } catch {
                        assertionFailure("Save error: \(error)")
                    }
                } label: {
                    Text("Save")
                        .font(UIStyles.body)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: UIStyles.radius)
                                .fill(
                                    LinearGradient(
                                        colors: [.purple, .indigo],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        )
                        .foregroundStyle(.white)
                }
                .disabled((note.title?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) ?? true)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.regularMaterial)
            .confirmationDialog("Do you want to delete this note?",
                                isPresented: $confirmDelete,
                                titleVisibility: .visible) {
                Button("Yes, Delete", role: .destructive) {
                    ctx.delete(note)
                    try? ctx.save()
                    dismiss()
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
}
