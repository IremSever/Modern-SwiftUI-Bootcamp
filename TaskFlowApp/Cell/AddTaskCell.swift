//
//  AddTaskCell.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 12.10.2025.
//


import SwiftUI

struct AddTaskCell: View {
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
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}
