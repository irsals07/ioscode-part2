//
//  FindItAppApp.swift
//  FindItApp
//
//  Created by Aaron Siam on 4/20/25.
//

import SwiftUI

@main
struct FindItAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppState())
        }
    }
}
