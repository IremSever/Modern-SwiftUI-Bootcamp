//
//  EventFlowContentView.swift
//  EventFlow
//
//  Created by İrem Sever on 15.10.2025.
//
import SwiftUI

private extension View {
    func appCard(cornerRadius: CGFloat = DesignTokens.radius) -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(.white.opacity(0.25), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
    }
}

struct EventFlowContentView: View {
    @StateObject private var store = EventStore()
    @State private var showNew = false
    @State private var query = ""
    @State private var selectedEvent: Event?
    @State private var selectedDay: Date = .now

    var filteredEvents: [Event] {
        let base = store.events
        return query.isEmpty
        ? base
        : base.filter { $0.title.localizedCaseInsensitiveContains(query)
            || $0.type.rawValue.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(.sRGB, red: 1.0,   green: 0.985, blue: 0.965, opacity: 1),
                        Color(.sRGB, red: 0.970, green: 0.975, blue: 1.000, opacity: 1)
                    ],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
                .overlay(
                    LinearGradient(colors: [.purple.opacity(0.05), .mint.opacity(0.05)],
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .ignoresSafeArea()

                VStack(spacing: 16) {

                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Events").font(DesignTokens.titleXL)
                            Text("List • Form • Detail flow")
                                .font(DesignTokens.sub)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button { showNew = true } label: {
                            Image(systemName: "square.and.pencil")
                                .font(.title3)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: DesignTokens.radius)
                                        .fill(.thinMaterial)
                                )
                        }
                        .accessibilityLabel("Add New Event")
                    }
                    .padding(14)
                    .padding(.horizontal)
                    .appCard()

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(0..<7) { offset in
                                let day = Calendar.current.date(byAdding: .day, value: offset, to: .now)!
                                DateChip(
                                    date: day,
                                    isSelected: Calendar.current.isDate(day, inSameDayAs: selectedDay)
                                )
                                .onTapGesture { selectedDay = day }
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                    }
                    .padding(.horizontal)
                    .appCard()

                    HStack(spacing: 10) {
                        SearchBar(text: $query)
                        Button("Find") { }
                            .font(DesignTokens.body)
                            .padding(.horizontal, 12).padding(.vertical, 10)
                            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16).stroke(.white.opacity(0.25), lineWidth: 1)
                            )
                    }
                    .padding(12)
                    .padding(.horizontal)
                    .appCard()

                    if filteredEvents.isEmpty {
                        ContentEmptyState(showNew: $showNew)
                            .padding(.top, 8)
                            .padding(.horizontal)
                            .appCard()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 14) {
                                ForEach(filteredEvents) { event in
                                    Button { selectedEvent = event } label: {
                                        EventCard(event: event)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 80)
                        }
                    }
                }
            }
            .sheet(item: $selectedEvent) { ev in
                EventDetailSheet(event: ev)
                    .environmentObject(store)
                    .presentationDetents([.height(DesignTokens.sheetHeight)])
                    .presentationCornerRadius(DesignTokens.radius)
            }
            .sheet(isPresented: $showNew) {
                NewEventSheet()
                    .environmentObject(store)
                    .presentationDetents([.medium, .large])
                    .presentationCornerRadius(DesignTokens.radius)
            }
            .environmentObject(store)
        }
    }
}

private struct DateChip: View {
    let date: Date
    let isSelected: Bool

    var body: some View {
        let weekday = Text(date.formatted(.dateTime.weekday(.abbreviated)))
            .font(DesignTokens.caption)
        let day = Text(date.formatted(.dateTime.day()))
            .font(DesignTokens.body).bold()

        Group {
            if isSelected {
                HStack(spacing: 8) {
                    VStack(spacing: 2) {
                        weekday.foregroundStyle(.white.opacity(0.9))
                        day.foregroundStyle(.white)
                    }
                }
                .padding(.horizontal, 14).padding(.vertical, 10)
                .background(
                    Capsule(style: .continuous)
                        .fill(.purple.gradient)
                )
                .overlay(
                    Capsule().strokeBorder(.white.opacity(0.25), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
            } else {
                HStack(spacing: 8) {
                    VStack(spacing: 2) {
                        weekday.foregroundStyle(.secondary)
                        day.foregroundStyle(.primary)
                    }
                }
                .padding(.horizontal, 14).padding(.vertical, 10)
                .background(
                    Capsule(style: .continuous).fill(.thinMaterial)
                )
                .overlay(
                    Capsule().strokeBorder(.white.opacity(0.25), lineWidth: 1)
                )
            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: isSelected)
    }
}


#Preview {
    EventFlowContentView()
}
