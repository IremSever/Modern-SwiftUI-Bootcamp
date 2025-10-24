//
//  ComposeNoteSheet.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 24.10.2025.
//
import SwiftUI
import CoreData

struct ComposeNoteSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var ctx

    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var content: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Title", text: $title)
                    DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    TextField("Content", text: $content, axis: .vertical)
                        .lineLimit(5, reservesSpace: true)
                }
            }
            .navigationTitle("New Note")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") { createNote() }
                        .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func createNote() {
        let obj = Note(context: ctx)
        obj.id = UUID()
        obj.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        obj.content = content
        obj.date = date
        do {
            try ctx.save()  
            dismiss()
        } catch {
            assertionFailure("Save error: \(error)")
        }
    }
}
