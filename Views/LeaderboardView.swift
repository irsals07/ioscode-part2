//
//  SignupView.swift
//  FindItApp
//
//  Created by Aaron Siam on 4/20/25.
//

import SwiftUI

import SwiftUI

struct LeaderboardView: View {
    @State private var selectedTab: NavigationBar.Tab = .leaderboard
    @State private var selectedLeaderboard: LeaderboardType = .friends
    
    enum LeaderboardType: String, CaseIterable {
        case friends = "Friends"
        case country = "Country"
        case global = "Global"
    }
    
    var body: some View {
        ZStack {
            // Background
            Color.blue.opacity(0.05).ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 20) {
                    Text("Leaderboard")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top)
                    
                    // Leaderboard type selector
                    HStack(spacing: 0) {
                        ForEach(LeaderboardType.allCases, id: \.self) { type in
                            Button {
                                withAnimation(.spring()) {
                                    selectedLeaderboard = type
                                }
                            } label: {
                                VStack {
                                    Text(type.rawValue)
                                        .font(.headline)
                                        .foregroundColor(selectedLeaderboard == type ? .blue : .gray)
                                        .padding(.vertical, 12)
                                        .padding(.horizontal, 20)
                                }
                                .background(
                                    ZStack {
                                        if selectedLeaderboard == type {
                                            CloudShape()
                                                .fill(Color.white)
                                                .shadow(color: Color.black.opacity(0.1), radius: 4)
                                        }
                                    }
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 10)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5)
                
                // Leaderboard content
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(getLeaderboardData(), id: \.id) { entry in
                            LeaderboardEntryRow(entry: entry, rank: entry.id)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
                
                // Navigation bar
                NavigationBar(selectedTab: $selectedTab)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
    
    func getLeaderboardData() -> [LeaderboardEntry] {
        switch selectedLeaderboard {
        case .friends:
            return [
                LeaderboardEntry(id: 1, name: "aaron", time: "1m 23s", photoCount: 12),
                LeaderboardEntry(id: 2, name: "jane", time: "2m 10s", photoCount: 8),
                LeaderboardEntry(id: 3, name: "bob", time: "5m 02s", photoCount: 5),
                LeaderboardEntry(id: 4, name: "emily", time: "5m 45s", photoCount: 10),
                LeaderboardEntry(id: 5, name: "david", time: "6m 31s", photoCount: 7)
            ]
        case .country:
            return [
                LeaderboardEntry(id: 1, name: "sarah", time: "0m 58s", photoCount: 15),
                LeaderboardEntry(id: 2, name: "aaron", time: "1m 23s", photoCount: 12),
                LeaderboardEntry(id: 3, name: "michael", time: "1m 45s", photoCount: 14),
                LeaderboardEntry(id: 4, name: "christina", time: "2m 02s", photoCount: 11),
                LeaderboardEntry(id: 5, name: "jane", time: "2m 10s", photoCount: 8)
            ]
        case .global:
            return [
                LeaderboardEntry(id: 1, name: "speedhunter", time: "0m 45s", photoCount: 20),
                LeaderboardEntry(id: 2, name: "quickfind", time: "0m 52s", photoCount: 18),
                LeaderboardEntry(id: 3, name: "sarah", time: "0m 58s", photoCount: 15),
                LeaderboardEntry(id: 4, name: "eagle_eye", time: "1m 15s", photoCount: 17),
                LeaderboardEntry(id: 5, name: "aaron", time: "1m 23s", photoCount: 12)
            ]
        }
    }
}

struct LeaderboardEntry: Identifiable {
    var id: Int
    var name: String
    var time: String
    var photoCount: Int
}

struct LeaderboardEntryRow: View {
    var entry: LeaderboardEntry
    var rank: Int
    
    var body: some View {
        HStack {
            // Rank
            ZStack {
                if rank <= 3 {
                    Circle()
                        .fill(rankColor)
                        .frame(width: 36, height: 36)
                    
                    Text("\(rank)")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                } else {
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        .frame(width: 36, height: 36)
                    
                    Text("\(rank)")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 40)
            
            // User info
            HStack {
                // Avatar
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(String(entry.name.prefix(1).uppercased()))
                            .font(.headline)
                            .foregroundColor(.blue)
                    )
                
                // Name and photo count
                VStack(alignment: .leading) {
                    Text(entry.name)
                        .font(.headline)
                    
                    Text("\(entry.photoCount) finds")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.leading, 8)
            
            Spacer()
            
            // Time
            Text(entry.time)
                .font(.headline)
                .foregroundColor(rank <= 3 ? rankColor : .primary)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(
                    Capsule()
                        .fill(rank <= 3 ? rankColor.opacity(0.1) : Color.gray.opacity(0.1))
                )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5)
        )
    }
    
    var rankColor: Color {
        switch rank {
        case 1:
            return Color.yellow
        case 2:
            return Color(hex: "C0C0C0") // Silver
        case 3:
            return Color(hex: "CD7F32") // Bronze
        default:
            return Color.blue
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    LeaderboardView()
}
