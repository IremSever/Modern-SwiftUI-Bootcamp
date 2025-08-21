//
//  VariablesAndDataTypes.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 21.08.2025.
//

import Foundation
import SwiftUI
struct VariablesAndDataTypes: View {
    @State private var person = Person(name: "İrem", age: 24, height: 178.5, isStudent: true, phoneNumber: "45645678")
    
    var body: some View {
        VStack() {
            Image(systemName: "person")
                .resizable()
                .foregroundColor(Color.orange.opacity(0.8))
                .frame(width: 50, height: 50)
                .foregroundStyle(.tint)
                .padding()
            VStack {
                Text("Personal Information Card")
                    .font(.headline)
                
                Text("Name: \(person.name ?? "")")
                Text("Age: \(person.age ?? 20)")
                Text("Height: \(person.height ?? 170)")
                let checkStudent: String = person.isStudent ?? false ? "Yes" : "No"
                Text("Student: \(checkStudent)")
                
                if let phone = person.phoneNumber {
                    Text("Phone Number: \(phone)")
                } else {
                    Text("Phone Number: Not provided")
                }
            }
            .frame(width: 300, height: 150)
            .border(Color.orange.opacity(0.8), width: 3)
        }
        .padding()
    }

}

#Preview {
    VariablesAndDataTypes()
}
