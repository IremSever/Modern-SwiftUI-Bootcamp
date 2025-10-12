//
//  AddTaskSheet.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 12.10.2025.
//
import SwiftUI

struct AddTaskSheet: View {
    @State private var title: String = ""
    var onAdd: (String) -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form { TextField("Task title", text: $title) }
                .navigationTitle("New Task")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) { Button("Cancel") { dismiss() } }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add") {
                            onAdd(title)
                            dismiss()
                        }
                        .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                }
        }
    }
}
