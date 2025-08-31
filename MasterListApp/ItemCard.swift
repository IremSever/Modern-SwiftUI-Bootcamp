//
//  ItemCard.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 31.08.2025.
//

import SwiftUI

struct ItemCard: View {
    var item: ListItem
    var toggleAction: () -> Void
    var deleteAction: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(item.isCompleted ? .gray : .primary)
                    .strikethrough(item.isCompleted)
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: toggleAction) {
                Image(systemName: item.isCompleted ? "arrow.uturn.backward.circle" : "checkmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(item.isCompleted ? .green : .purple)
            }
            .buttonStyle(BorderlessButtonStyle())
            
            Button(action: deleteAction) {
                Image(systemName: "trash")
                    .font(.title2)
                    .foregroundColor(.red)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 4, y: 3)
    }
}
