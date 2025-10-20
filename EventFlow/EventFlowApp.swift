//
//  EventFlowApp.swift
//  EventFlow
//
//  Created by İrem Sever on 15.10.2025.
//

import SwiftUI

@main
struct EventFlowApp: App {
    @StateObject private var store = EventStore() 
    var body: some Scene {
        WindowGroup {
            EventFlowContentView()
                .environmentObject(store)
        }
    }
}
