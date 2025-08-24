//
//  InfoCard.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 24.08.2025.
//
import SwiftUI

struct InfoCard: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.orange)
            
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .background(Color.yellow.opacity(0.15))
        .cornerRadius(12)
    }
}
