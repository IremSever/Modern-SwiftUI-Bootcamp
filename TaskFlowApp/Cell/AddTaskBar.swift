//
//  AddTaskBar.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 12.10.2025.
//
import SwiftUI

struct AddTaskBar: View {
    var onTap: () -> Void
    var body: some View {
        Button(action: onTap) {
            HStack {
                Spacer()
                Text("Add new task").font(.headline)
                Image(systemName: "plus")
                Spacer()
            }
            .padding(.vertical, 14)
            .background(Capsule().fill(AppTheme.tint))
            .foregroundStyle(.white)
        }
        .shadow(color: .black.opacity(0.08), radius: 8, y: 3)
    }
}
