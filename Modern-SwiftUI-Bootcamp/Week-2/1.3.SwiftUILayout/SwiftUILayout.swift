//
//  SwiftUILayout.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 24.08.2025.
//

import SwiftUI

struct SwiftUILayout: View {
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                LinearGradient(colors: [.yellow, .purple],
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 8) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                    
                    Text("John Wick")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem.")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 40)
                        .multilineTextAlignment(.center)
                    
                }
            }
            .frame(height: 300)
            
            HStack(spacing: 16) {
                InfoCard(title: "Takipçi", value: "1200")
                InfoCard(title: "Takip Edilen", value: "300")
                InfoCard(title: "Beğeni", value: "5000")
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 25)
            VStack(alignment: .center, spacing: 12) {
                Text("About Me")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.orange)
                ScrollView {
                    Text("Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem.Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem. ")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        
                }
                .frame(height: 150)
            }
            .padding(.horizontal, 16)
            
            Spacer()
            
            HStack(spacing: 20) {
                Button(action: {
                    print("Mesaj Gönder")
                }) {
                    Text("Mesaj Gönder")
                        .font(.system(size: 16, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple.opacity(0.2))
                        .cornerRadius(12)
                        .foregroundStyle(.purple)
                }
                
                Button(action: {
                    print("Takip Et")
                }) {
                    Text("Takip Et")
                        .font(.system(size: 16, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple.opacity(0.2))
                        .cornerRadius(12)
                        .foregroundStyle(.purple)
                }
            }
            .padding(.horizontal,16)
            .padding(.bottom, 32)
            
        }
    }
}

#Preview {
    SwiftUILayout()
}
