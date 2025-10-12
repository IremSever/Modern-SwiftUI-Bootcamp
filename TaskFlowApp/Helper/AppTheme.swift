//
//  AppTheme.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 12.10.2025.
//
import SwiftUI

enum AppTheme {
    static let gradient = LinearGradient(
        colors: [
            Color(#colorLiteral(red: 0.95, green: 0.98, blue: 1.0, alpha: 1)),
            Color(#colorLiteral(red: 0.92, green: 0.96, blue: 1.0, alpha: 1)),
            Color(#colorLiteral(red: 0.98, green: 0.94, blue: 1.0, alpha: 1))
        ],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let tint   = Color(#colorLiteral(red: 0.23, green: 0.62, blue: 0.98, alpha: 1))
    static let purple = Color(#colorLiteral(red: 0.56, green: 0.44, blue: 0.97, alpha: 1))
    static let blue   = Color(#colorLiteral(red: 0.31, green: 0.66, blue: 0.99, alpha: 1))
    static let green  = Color(#colorLiteral(red: 0.22, green: 0.75, blue: 0.54, alpha: 1))
    static let teal   = Color(#colorLiteral(red: 0.20, green: 0.74, blue: 0.68, alpha: 1))
}

struct SoftBackground: View {
    var body: some View { AppTheme.gradient.ignoresSafeArea() }
}
