//
//  AddItemView.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 31.08.2025.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ListViewModel
    
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add New Item")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if !title.isEmpty {
                            viewModel.addItem(title: title, description: description)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
