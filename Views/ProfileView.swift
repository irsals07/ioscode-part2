//
//  ProfileView.swift
//  FindItApp
//
//  Created by _ on 4/22/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var selectedTab: NavigationBar.Tab = .profile
    @State private var selectedFilter: String = "All Finds"
    
    let filters = ["All Finds", "Best Times", "Collections"]
    
    var body: some View {
        ZStack {
            // Background
            Color.blue.opacity(0.05).ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Profile header
                VStack(spacing: 24) {
                    // User info section
                    HStack(spacing: 24) {
                        // Profile image
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.blue, .blue.opacity(0.7)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 90, height: 90)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                            )
                            .shadow(color: .blue.opacity(0.3), radius: 8)
                        
                        // Stats
                        VStack(alignment: .leading, spacing: 8) {
                            Text("aaron")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            HStack(spacing: 24) {
                                VStack {
                                    Text("12")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    Text("Finds")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                VStack {
                                    Text("1:23")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    Text("Best")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                VStack {
                                    Text("5")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    Text("Streak")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Bio section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("FindIt Master")
                            .font(.headline)
                        
                        Text("Finding things since April 2025. Always up for a challenge!")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    // Filter tabs
                    HStack {
                        ForEach(filters, id: \.self) { filter in
                            Button {
                                selectedFilter = filter
                            } label: {
                                Text(filter)
                                    .font(.subheadline)
                                    .fontWeight(selectedFilter == filter ? .semibold : .regular)
                                    .foregroundColor(selectedFilter == filter ? .blue : .gray)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 16)
                                    .background(
                                        ZStack {
                                            if selectedFilter == filter {
                                                CloudShape()
                                                    .fill(Color.white)
                                                    .shadow(color: Color.black.opacity(0.05), radius: 4)
                                            }
                                        }
                                    )
                            }
                        }
                    }
                    .padding(.top, 8)
                }
                .padding(.top, 16)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5)
                
                // Gallery grid
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 2),
                        GridItem(.flexible(), spacing: 2),
                        GridItem(.flexible(), spacing: 2)
                    ], spacing: 2) {
                        ForEach(1...12, id: \.self) { index in
                            FindItemCell(index: index)
                        }
                    }
                    .padding(.top, 2)
                }
                
                // Navigation bar
                NavigationBar(selectedTab: $selectedTab)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct FindItemCell: View {
    var index: Int
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Placeholder image
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.gray.opacity(0.2))
                .aspectRatio(1, contentMode: .fill)
                .overlay(
                    Image(systemName: ["car.fill", "umbrella", "cup.and.saucer.fill", "bicycle", "fork.knife"][index % 5])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.gray)
                )
            
            // Time indicator
            Text(randomTime)
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(Color.blue.opacity(0.8))
                .cornerRadius(4)
                .padding(4)
        }
    }
    
    var randomTime: String {
        let minutes = [1, 2, 3, 0]
        let seconds = [12, 23, 45, 58, 32]
        return "\(minutes[index % minutes.count]):\(seconds[index % seconds.count])"
    }
}

#Preview {
    ProfileView()
}
