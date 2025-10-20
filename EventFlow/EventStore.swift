//
//  EventStore.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 15.10.2025.
//
import SwiftUI
import Combine

final class EventStore: ObservableObject {
    @Published private(set) var events: [Event] = [] {
        didSet { save() }
    }
    
    
    private let storageKey = "events.storage.v1"
    
    
    init(seedIfEmpty: Bool = true) {
        load()
        if seedIfEmpty && events.isEmpty {
            events = Self.seeds
        }
    }
    
    
    func add(title: String, date: Date, type: EventType, hasReminder: Bool) {
        let new = Event(title: title, date: date, type: type, hasReminder: hasReminder)
        withAnimation(.spring) {
            events.append(new)
            sort()
        }
    }
    
    
    func delete(_ event: Event) {
        withAnimation(.easeInOut) {
            events.removeAll { $0.id == event.id }
        }
    }
    
    
    func toggleReminder(for event: Event) {
        guard let idx = events.firstIndex(of: event) else { return }
        withAnimation(.snappy) {
            events[idx].hasReminder.toggle()
        }
    }
    
    
    func update(_ event: Event, title: String, date: Date, type: EventType, hasReminder: Bool, accent: Accent) {
        guard let idx = events.firstIndex(of: event) else { return }
        withAnimation(.spring) {
            events[idx].title = title
            events[idx].date = date
            events[idx].type = type
            events[idx].hasReminder = hasReminder
            events[idx].accent = accent
            sort()
        }
    }
    
    
    private func sort() { events.sort { $0.date < $1.date } }
    
    
    private func save() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(events) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([Event].self, from: data) {
            events = decoded
        }
    }
    
    
    static let seeds: [Event] = [
        Event(title: "iOS Standup", date: .now.addingTimeInterval(3600*24), type: .meeting, hasReminder: true),
        Event(title: "Birthday - İrem", date: .now.addingTimeInterval(3600*48), type: .birthday, hasReminder: true),
        Event(title: "Run", date: .now.addingTimeInterval(3600*24*3), type: .sport, hasReminder: false),
        Event(title: "İzmir", date: .now.addingTimeInterval(3600*24*10), type: .vacation, hasReminder: false)
    ]
}
