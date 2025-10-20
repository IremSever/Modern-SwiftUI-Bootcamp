//
//  Event.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 15.10.2025.
//

import SwiftUI

struct Event: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var title: String
    var date: Date
    var type: EventType
    var hasReminder: Bool
    var accent: Accent = .candyRed

    init(id: UUID = UUID(), title: String, date: Date, type: EventType, hasReminder: Bool, accent: Accent = .candyRed) {
        self.id = id; self.title = title; self.date = date; self.type = type; self.hasReminder = hasReminder; self.accent = accent
    }

    enum CodingKeys: String, CodingKey { case id, title, date, type, hasReminder, accent }
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(UUID.self, forKey: .id)
        title = try c.decode(String.self, forKey: .title)
        date = try c.decode(Date.self, forKey: .date)
        type = try c.decode(EventType.self, forKey: .type)
        hasReminder = try c.decode(Bool.self, forKey: .hasReminder)
        accent = (try? c.decode(Accent.self, forKey: .accent)) ?? .candyRed
    }
}

enum EventType: String, CaseIterable, Codable, Identifiable {
    case birthday = "Birthday"
    case meeting = "Meeting"
    case vacation = "Vacaation"
    case sport = "Sport"
    case other = "Other"
    
    
    var id: String { rawValue }
    var systemImage: String {
        switch self {
        case .birthday: return "gift"
        case .meeting: return "person.2.fill"
        case .vacation: return "beach.umbrella.fill"
        case .sport: return "figure.run.circle.fill"
        case .other: return "sparkles"
        }
    }
    var tint: Color {
        switch self {
        case .birthday: return .pink
        case .meeting: return .blue
        case .vacation: return .orange
        case .sport: return .green
        case .other: return .purple
        }
    }
}

enum Accent: String, CaseIterable, Codable, Identifiable {
    case candyRed = "Candy Red"
    case skyBlue  = "Sky Blue"
    case mint     = "Mint"
    case lavender = "Lavender"
    case orange   = "Sunset Orange"
    case graphite = "Graphite"

    var id: String { rawValue }
    var color: Color {
        switch self {
        case .candyRed: return .red
        case .skyBlue:  return .blue
        case .mint:     return .mint
        case .lavender: return .purple
        case .orange:   return .orange
        case .graphite: return .gray
        }
    }
}
