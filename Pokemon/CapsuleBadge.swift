//
//  CapsuleBadge.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 25.10.2025.
//


import SwiftUI

private struct CapsuleBadge: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
            Text(text)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .font(.caption2.weight(.semibold))
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .foregroundStyle(.white)
        .background(.white.opacity(0.18), in: Capsule())
    }
}


