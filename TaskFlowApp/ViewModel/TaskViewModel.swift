//
//  TaskViewModel.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 12.10.2025.
//
import Foundation
import SwiftUI
internal import Combine

final class TaskViewModel: ObservableObject {
    @Published private(set) var tasks: [Task] = []
    @Published var filter: Filter = .all
    
    enum Filter: String, CaseIterable, Identifiable {
        case all = "All"
        case active = "Active"
        case completed = "Completed"
        var id: String { rawValue }
    }
    
    var filteredTasks: [Task] {
        switch filter {
        case .all: return tasks
        case .active: return tasks.filter { !$0.isCompleted }
        case .completed: return tasks.filter { $0.isCompleted }
        }
    }
    
    var activeCount: Int { tasks.filter { !$0.isCompleted }.count }
    var completedCount: Int { tasks.filter { $0.isCompleted }.count }
    
    // MARK: intents
    func addTask(title: String) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        tasks.insert(Task(title: trimmed), at: 0)
    }
    
    func toggleCompleted(for task: Task) {
        guard let idx = tasks.firstIndex(of: task) else { return }
        tasks[idx].isCompleted.toggle()
    }
    
    func remove(_ task: Task) {
        if let idx = tasks.firstIndex(of: task) {
            withAnimation { tasks.remove(at: idx) }
        }
    }
    
    func delete(at offsets: IndexSet) {
        let ids = offsets.map { filteredTasks[$0].id }
        tasks.removeAll { ids.contains($0.id) }
    }
    
    func clearCompleted() {
        tasks.removeAll { $0.isCompleted }
    }
    
    func seed() {
        guard tasks.isEmpty else { return }
        tasks = [
            Task(title: "Read MVVM notes"),
            Task(title: "Build SwiftUI grid"),
            Task(title: "Polish UI", isCompleted: true)
        ]
    }
}
