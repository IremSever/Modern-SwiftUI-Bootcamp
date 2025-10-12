//
//  HeaderStatsCell.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 12.10.2025.
//
import SwiftUI

struct HeaderStatsCell: View {
    let userName: String
    let total: Int
    let done: Int
    @Binding var search: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Hi, \(userName)").font(.callout).foregroundStyle(.secondary)
            Text("Be productive today").font(.title2.weight(.bold))
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Task Progress").font(.headline)
                    Text("\(done)/\(total) task done").foregroundStyle(.secondary)
                    Label(Date.now.formatted(.dateTime.month(.abbreviated).day()), systemImage: "calendar")
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 10).padding(.vertical, 6)
                        .background(Capsule().fill(AppTheme.tint.opacity(0.12)))
                }
                Spacer()
                ProgressRing(progress: total == 0 ? 0 : Double(done)/Double(total))
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(.background)
                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(.black.opacity(0.06)))
                    .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
            )
        }
        .padding(.horizontal)
        .padding(.top, 6)

        SearchBarCell(text: $search)
    }
}
