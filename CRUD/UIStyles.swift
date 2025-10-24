//
//  UIStyles.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 24.10.2025.
//

import SwiftUI
import CoreData

enum UIStyles {
    static let radius: CGFloat = 16
    static let titleXL  = Font.system(size: 28, weight: .semibold, design: .rounded)
    static let title    = Font.system(size: 20, weight: .bold,     design: .rounded)
    static let body     = Font.system(size: 16, weight: .regular,  design: .rounded)
    static let sub      = Font.system(size: 14, weight: .regular,  design: .rounded)
    static let caption  = Font.system(size: 12, weight: .regular,  design: .rounded)
}

extension View {
    func notebookCard() -> some View {
        self.background(.ultraThinMaterial,
                        in: RoundedRectangle(cornerRadius: UIStyles.radius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: UIStyles.radius, style: .continuous)
                    .stroke(.white.opacity(0.25), lineWidth: 1)
            )
    }
    func notebookField() -> some View {
        self.background(.thinMaterial,
                        in: RoundedRectangle(cornerRadius: UIStyles.radius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: UIStyles.radius, style: .continuous)
                    .stroke(.white.opacity(0.25), lineWidth: 1)
            )
    }
}
