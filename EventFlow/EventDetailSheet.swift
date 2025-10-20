//
//  EventDetailSheet.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 15.10.2025.
//

import SwiftUI
fileprivate extension Date {
    var startOfDay: Date { Calendar.current.startOfDay(for: self) }
}

struct EventDetailSheet: View {
    @EnvironmentObject private var store: EventStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var editable: Event
    @State private var showDeleteConfirm = false
    
    private let today = Date().startOfDay
    
    init(event: Event) { _editable = State(initialValue: event) }
    
    private var yearText: String {
        String(Calendar.current.component(.year, from: editable.date))
    }
    
    private var futureYears: [Int] {
        let current = Calendar.current.component(.year, from: Date())
        return Array(current...(current + 10))
    }
    
    private var isPast: Bool { editable.date.startOfDay < today }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(.sRGB, red: 1.0,   green: 0.985, blue: 0.965, opacity: 1),
                    Color(.sRGB, red: 0.970, green: 0.975, blue: 1.000, opacity: 1)
                ],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 14) {
                
                VStack {
                    
                    Text("Select Date").font(DesignTokens.title)
                        .padding(.bottom, 12)
                    DatePicker(
                        "",
                        selection: $editable.date,
                        in: today...,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .frame(height: 280)
                }
                .padding(12)
                .appCard()
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Information").font(DesignTokens.title)
                    
                    HStack(spacing: 10) {
                        Image(systemName: "text.cursor").foregroundStyle(.secondary)
                        TextField("Website Project", text: $editable.title)
                            .font(DesignTokens.body)
                            .lineLimit(1).minimumScaleFactor(0.9)
                    }
                    .padding(12)
                    .appField()
                    
                    HStack(spacing: 10) {
                        Menu {
                            ForEach(EventType.allCases) { t in
                                Button { editable.type = t } label: { Label(t.rawValue, systemImage: t.systemImage) }
                            }
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: editable.type.systemImage)
                                Text(editable.type.rawValue)
                                    .font(DesignTokens.body)
                                    .lineLimit(1).minimumScaleFactor(0.9)
                            }
                            .padding(.horizontal, 12).padding(.vertical, 10)
                            .appField()
                        }
                        
                        Menu {
                            ForEach(Accent.allCases) { acc in
                                Button {
                                    editable.accent = acc
                                } label: {
                                    Label(acc.rawValue, systemImage: "circle.fill")
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(acc.color, .clear)
                                }
                            }
                        } label: {
                            HStack(spacing: 8) {
                                   Image(systemName: "circle.fill")
                                       .symbolRenderingMode(.palette)
                                       .foregroundStyle(editable.accent.color, .clear)
                                   Text(editable.accent.rawValue)         
                                       .font(DesignTokens.sub)
                               }
                               .padding(.horizontal, 12).padding(.vertical, 10)
                               .appField()
                        }
                        
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Get alert for this reminder").font(DesignTokens.sub)
                            Text("We’ll notify you before it starts.")
                                .font(DesignTokens.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Toggle("", isOn: $editable.hasReminder)
                            .labelsHidden()
                            .disabled(isPast)
                    }
                }
                .padding(16)
                .appCard()
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 12) {
                Button(role: .destructive) {
                    showDeleteConfirm = true
                } label: {
                    Text("Delete")
                        .font(DesignTokens.body)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: DesignTokens.radius)
                                .fill(Color.red.opacity(0.12))
                        )
                }
                .foregroundStyle(.red)
                
                Button {
                    guard !isPast else { return }
                    store.update(
                        editable,
                        title: editable.title,
                        date: editable.date,
                        type: editable.type,
                        hasReminder: editable.hasReminder,
                        accent: editable.accent
                    )
                    dismiss()
                } label: {
                    Text("Create Reminder")
                        .font(DesignTokens.body)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: DesignTokens.radius)
                                .fill(LinearGradient(colors: [.purple, .indigo],
                                                     startPoint: .leading, endPoint: .trailing))
                        )
                        .foregroundStyle(.white)
                }
                .disabled(isPast || editable.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .opacity(isPast ? 0.5 : 1)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.regularMaterial)
            .confirmationDialog("Delete this event?",
                                isPresented: $showDeleteConfirm,
                                titleVisibility: .visible) {
                Button("Yes, Delete", role: .destructive) {
                    store.delete(editable); dismiss()
                }
                Button("Cancel", role: .cancel) { }
            }
        }
        .presentationDetents([.height(DesignTokens.sheetHeight)])
        .presentationCornerRadius(DesignTokens.radius)
        .presentationDragIndicator(.visible)
    }
}
