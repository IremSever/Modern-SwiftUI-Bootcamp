//
//  CRUDApp.swift
//  CRUD
//
//  Created by İrem Sever on 24.10.2025.
//

import SwiftUI
import CoreData

@main
struct CRUDApp: App {
    let dataStack = DataStack.shared
    var body: some Scene {
        WindowGroup {
            NotebookHomeView()
                .environment(\.managedObjectContext, dataStack.container.viewContext)
        }
    }
}
