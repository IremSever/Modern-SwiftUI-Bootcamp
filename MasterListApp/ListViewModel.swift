//
//  ListViewModel.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 31.08.2025.
//

import SwiftUI

class ListViewModel: ObservableObject {
    @Published var items: [ListItem] = [
        ListItem(title: "Read a Book", description: "At least 30 minutes daily"),
        ListItem(title: "Exercise", description: "10k steps target"),
        ListItem(title: "Finish Project", description: "Complete SwiftUI assignment"),
        ListItem(title: "Call a Friend", description: "Haven’t talked in a while"),
        ListItem(title: "Pay Bills", description: "Electricity and water"),
        ListItem(title: "Watch a Movie", description: "Plan for the weekend"),
        ListItem(title: "Listen to Music", description: "Discover a new album"),
        ListItem(title: "Cook a Meal", description: "Try a healthy recipe"),
        ListItem(title: "Write Journal", description: "Summarize your day"),
        ListItem(title: "Meditation", description: "15 minutes mindfulness")
    ]
    
    func addItem(title: String, description: String) {
        items.append(ListItem(title: title, description: description))
    }
    
    func deleteItem(item: ListItem) {
        items.removeAll { $0.id == item.id }
    }
    
    func toggleComplete(item: ListItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted.toggle()
        }
    }
}
