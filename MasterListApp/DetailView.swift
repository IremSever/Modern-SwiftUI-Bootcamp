//
//  DetailView.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 31.08.2025.
//

import SwiftUI

struct DetailView: View {
    let item: ListItem
    let symbols = ["star.fill", "bolt.fill", "heart.fill", "leaf.fill", "moon.fill", "flame.fill"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text(item.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(item.description)
                .font(.body)
                .foregroundColor(.secondary)
            
            Image(systemName: symbols.randomElement() ?? "star.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
                .foregroundColor(.blue)
                .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}
