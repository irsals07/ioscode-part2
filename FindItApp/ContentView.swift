//
//  ContentView.swift
//  FindItApp
//
//  Created by Aaron Siam on 4/20/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        if !appState.isSignedIn {
            SignupView()
                .transition(.opacity)
        } else if !appState.hasSeenItemReveal {
            ItemRevealView()
                .transition(.move(edge: .bottom))
        } else {
            MainContentView()
                .transition(.opacity)
        }
    }
}


#Preview {
    ContentView()
        .environmentObject(AppState())
}
