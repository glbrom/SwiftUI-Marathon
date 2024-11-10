//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Roman Golub on 17.10.2024.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
