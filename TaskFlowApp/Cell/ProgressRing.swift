//
//  ProgressRing.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 12.10.2025.
//
import SwiftUI

struct ProgressRing: View {
    var progress: Double 

    var body: some View {
        ZStack {
            Circle().stroke(.gray.opacity(0.15), lineWidth: 10)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(AppTheme.tint, style: .init(lineWidth: 10, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 0.5), value: progress)
            Text("\(Int(progress * 100))%")
                .font(.caption.weight(.semibold))
                .monospacedDigit()
        }
        .frame(width: 56, height: 56)
    }
}
