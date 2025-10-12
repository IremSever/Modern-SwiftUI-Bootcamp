//
//  TaskContentView.swift
//  TaskFlowApp
//
//  Created by İrem Sever on 12.10.2025.
//

import SwiftUI
struct TaskContentView: View {
    @StateObject private var vm = TaskViewModel()
    @State private var search = ""
    @State private var showAdd = false
    
    private let columns = [GridItem(.flexible(), spacing: 12),
                           GridItem(.flexible(), spacing: 12)]
    
    private var filtered: [Task] {
        let base = vm.filteredTasks
        let s = search.trimmingCharacters(in: .whitespaces)
        guard !s.isEmpty else { return base }
        return base.filter { $0.title.localizedCaseInsensitiveContains(s) }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                SoftBackground()
                ScrollView {
                    VStack(spacing: 12) {
                        HeaderStatsCell(userName: "İrem",
                                        total: vm.tasks.count,
                                        done: vm.completedCount,
                                        search: $search)
                        
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(filtered) { task in
                                TaskCardCell(
                                    task: task,
                                    color: colorFor(task: task),
                                    fixedHeight: 148,
                                    onToggle: { vm.toggleCompleted(for: task) },
                                    onDelete: { vm.remove(task) }
                                )
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                    }
                }
            }
            .navigationTitle("TaskFlow")
            .safeAreaInset(edge: .bottom) {
                ZStack {
       
                    AddTaskBar { showAdd = true }
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                }
            }
            .sheet(isPresented: $showAdd) {
                AddTaskSheet { title in vm.addTask(title: title) }
            }
            .onAppear { vm.seed() }
        }
    }
    
    private func colorFor(task: Task) -> Color {
        let palette: [Color] = [AppTheme.purple, AppTheme.blue, AppTheme.teal, AppTheme.green]
        if let idx = vm.tasks.firstIndex(of: task) { return palette[idx % palette.count] }
        return AppTheme.blue
    }
}

#Preview {
    TaskContentView()
}
