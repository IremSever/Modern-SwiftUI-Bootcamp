//
//  SearchBarCell.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 12.10.2025.
//
import SwiftUI

struct SearchBarCell: View {
    @Binding var text: String
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
            TextField("Search task", text: $text)
                .textInputAutocapitalization(.never)
        }
        .padding(.horizontal, 14).padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(.background)
                .overlay(RoundedRectangle(cornerRadius: 14).stroke(.black.opacity(0.06)))
                .shadow(color: .black.opacity(0.05), radius: 6, y: 3)
        )
        .padding(.horizontal)
        .padding(.top, 6)
    }
}
