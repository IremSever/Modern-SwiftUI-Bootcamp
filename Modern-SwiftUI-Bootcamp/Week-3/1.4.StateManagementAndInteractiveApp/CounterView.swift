//
//  SwiftUIView.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 30.08.2025.
//

import SwiftUI

struct CounterView: View {
    @State private var counter: Int = 0
    @State private var rotateBg = false

    var body: some View {
           ZStack {
               LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                              startPoint: .topLeading,
                              endPoint: .bottomTrailing)
                   .ignoresSafeArea()
               
               VStack(spacing: 40) {
                   ZStack {
                       RoundedRectangle(cornerRadius: 40)
                           .strokeBorder(
                            LinearGradient(colors: [.yellow.opacity(0.05),
                                                    .white.opacity(0.2),
                                                    .mint.opacity(0.10)],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing),
                            lineWidth: 8
                           )
                           .frame(width: 100, height: 100)
                           .rotationEffect(.degrees(rotateBg ? 360 : 0))
                           .animation(.linear(duration: 10).repeatForever(autoreverses: false), value: rotateBg)
                           .onAppear { rotateBg = true }
                       
                       Text("COUNTER")
                           .font(.system(size: 40, weight: .bold))
                           .foregroundColor(.white)
                           .shadow(radius: 10)
                   }
                   .padding(.top, 20)
                   Text("\(counter)")
                       .font(.system(size: 100, weight: .heavy))
                       .foregroundColor(.white)
                       .shadow(radius: 10)
                   
                   HStack(spacing: 50) {
                       Button(action: {
                           if counter > 0 {
                               counter -= 1
                           }
                       }) {
                           Image(systemName: "minus.circle.fill")
                               .font(.system(size: 60))
                               .foregroundColor(.red)
                               .shadow(radius: 5)
                       }
                       
                       Button(action: {
                           counter = 0 
                       }) {
                           Image(systemName: "arrow.counterclockwise.circle.fill")
                               .font(.system(size: 60))
                               .foregroundColor(.yellow)
                               .shadow(radius: 5)
                       }
                       
                       Button(action: {
                           counter += 1
                       }) {
                           Image(systemName: "plus.circle.fill")
                               .font(.system(size: 60))
                               .foregroundColor(.green)
                               .shadow(radius: 5)
                       }
                   }
               }
               .padding()
           }
    }
    
}

#Preview {
    CounterView()
}
