//
//  ContentView.swift
//  MasterListApp
//
//  Created by İrem Sever on 31.08.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ListViewModel()
    @State private var showAddSheet = false
    @State private var bgColor: Color = .white
    
    var body: some View {
        NavigationView {
            ZStack {
                bgColor.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // To-Do Section
                        if !viewModel.items.filter({ !$0.isCompleted }).isEmpty {
                            Text("📝 To-Do")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                            
                            LazyVStack(spacing: 15) {
                                ForEach(viewModel.items.filter { !$0.isCompleted }) { item in
                                    NavigationLink(destination: DetailView(item: item)) {
                                        ItemCard(item: item,
                                                 toggleAction: { viewModel.toggleComplete(item: item) },
                                                 deleteAction: { viewModel.deleteItem(item: item) })
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Completed Section
                        if !viewModel.items.filter({ $0.isCompleted }).isEmpty {
                            Text("🎉 Completed")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                            
                            LazyVStack(spacing: 15) {
                                ForEach(viewModel.items.filter { $0.isCompleted }) { item in
                                    NavigationLink(destination: DetailView(item: item)) {
                                        ItemCard(item: item,
                                                 toggleAction: { viewModel.toggleComplete(item: item) },
                                                 deleteAction: { viewModel.deleteItem(item: item) })
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
                // 👇 Floating Button için scroll'un altına boşluk bırakıyoruz
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 80)
                }
                
                // Floating Add Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { showAddSheet.toggle() }) {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("MasterListApp")
            .onAppear {
                bgColor = [Color.red.opacity(0.1),
                           Color.blue.opacity(0.1),
                           Color.green.opacity(0.1),
                           Color.orange.opacity(0.1),
                           Color.purple.opacity(0.1)].randomElement() ?? .white
            }
            .sheet(isPresented: $showAddSheet) {
                AddItemView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}


