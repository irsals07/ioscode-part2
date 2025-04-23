//
//  MainContentView.swift
//  FindItApp
//
//  Created by _ on 4/22/25.
//

import SwiftUI

struct MainContentView: View {
    @EnvironmentObject private var appState: AppState
    @State private var showItemRevealOverlay = false
    
    var body: some View {
        ZStack {
            // Content based on selected tab
            Group {
                if appState.selectedTab == .home {
                    HomeView(showItemRevealOverlay: $showItemRevealOverlay)
                } else if appState.selectedTab == .camera {
                    CameraView()
                } else if appState.selectedTab == .leaderboard {
                    LeaderboardView()
                } else if appState.selectedTab == .profile {
                    ProfileView()
                }
            }
            
            // Navigation bar (except for camera view which has its own)
            if appState.selectedTab != .camera {
                VStack {
                    Spacer()
                    NavigationBar(selectedTab: $appState.selectedTab)
                }
            }
            
            // Item reveal overlay
            if showItemRevealOverlay {
                ItemRevealOverlay(isPresented: $showItemRevealOverlay)
                    .transition(.opacity)
            }
        }
        .onAppear {
            // Show the item reveal overlay when first entering the home view
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showItemRevealOverlay = true
            }
        }
    }
}
