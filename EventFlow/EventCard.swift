//
//  EventCard.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 15.10.2025.
//

import SwiftUI
struct EventCard: View {
    let event: Event
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            ZStack {
                Circle().fill(event.accent.color.gradient) 
                    .frame(width: 54, height: 54)
                    .overlay(
                        Circle().strokeBorder(.white.opacity(0.35), lineWidth: 1)
                    )
                    .shadow(radius: 6, y: 3)
                Image(systemName: event.type.systemImage)
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            
            
            VStack(alignment: .leading, spacing: 6) {
                Text(event.title)
                    .font(.headline)
                    .lineLimit(1)
                HStack(spacing: 8) {
                    Label(event.date.formatted(date: .abbreviated, time: .shortened), systemImage: "clock")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    TypePill(type: event.type)
                }
            }
            Spacer()
            if event.hasReminder {
                Image(systemName: "bell.badge.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.yellow, .white)
                    .font(.title3)
                    .accessibilityLabel("Reminder")
            }
        }
        .padding(16)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(.white.opacity(0.25), lineWidth: 1)
        )
    }
}

struct TypePill: View {
    let type: EventType
    var body: some View {
        HStack(spacing: 6) {
            Circle().fill(type.tint).frame(width: 6, height: 6)
            Text(type.rawValue).font(.caption).foregroundStyle(.secondary)
        }
        .padding(.horizontal, 10).padding(.vertical, 4)
        .background(
            Capsule().fill(.thinMaterial)
        )
        .overlay(
            Capsule().strokeBorder(.white.opacity(0.25), lineWidth: 1)
        )
    }
}
struct NewEventSheet: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var store: EventStore
    
    
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var type: EventType = .other
    @State private var hasReminder: Bool = false
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Bilgiler") {
                    TextField("Event Name", text: $title)
                    DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    Picker("Type", selection: $type) {
                        ForEach(EventType.allCases) { t in
                            Label(t.rawValue, systemImage: t.systemImage).tag(t)
                        }
                    }
                    Toggle("Reminder", isOn: $hasReminder)
                }
            }
            .navigationTitle("New Event")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        store.add(title: title.trimmingCharacters(in: .whitespacesAndNewlines),
                                  date: date,
                                  type: type,
                                  hasReminder: hasReminder)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
        .accentColor(type.tint)
    }
}
struct ContentEmptyState: View {
    @Binding var showNew: Bool
    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "tray")
                .font(.system(size: 48, weight: .bold))
                .foregroundStyle(.secondary)
            Text("No events yet.")
                .font(.title3).bold()
            Text("Add an event with the + button in the top right.")
                .foregroundStyle(.secondary)
            Button {
                showNew = true
            } label: {
                Label("New Event", systemImage: "plus")
                    .padding(.horizontal, 14).padding(.vertical, 10)
                    .background(.thinMaterial, in: Capsule())
            }
        }
        .padding()
    }
}
