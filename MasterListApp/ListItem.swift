//
//  ListItem.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 31.08.2025.
//

import SwiftUI

struct ListItem: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var isCompleted: Bool = false
}
