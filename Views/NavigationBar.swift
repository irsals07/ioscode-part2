//
//  NavigationBar.swift
//  FindItApp
//
//  Created by _ on 4/22/25.
//

import SwiftUI

struct NavigationBar: View {
    @Binding var selectedTab: Tab
    
    enum Tab {
        case home, camera, leaderboard, profile
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                selectedTab = .home
            } label: {
                VStack(spacing: 4) {
                    Image(systemName: "house.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                    Text("Home")
                        .font(.caption)
                }
                .foregroundColor(selectedTab == .home ? .blue : .gray)
            }
            
            Spacer()
            
            Button {
                selectedTab = .camera
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: "camera.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            }
            .offset(y: -15)
            
            Spacer()
            
            Button {
                selectedTab = .leaderboard
            } label: {
                VStack(spacing: 4) {
                    Image(systemName: "trophy.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                    Text("Leaders")
                        .font(.caption)
                }
                .foregroundColor(selectedTab == .leaderboard ? .blue : .gray)
            }
            
            Spacer()
            
            Button {
                selectedTab = .profile
            } label: {
                VStack(spacing: 4) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                    Text("Profile")
                        .font(.caption)
                }
                .foregroundColor(selectedTab == .profile ? .blue : .gray)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -2)
        )
    }
}
