//
//  SignupView.swift
//  FindItApp
//
//  Created by Aaron Siam on 4/20/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var appState: AppState
    @State private var startTime = Date()
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer?
    @Binding var showItemRevealOverlay: Bool
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.white]),
                          startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // Cloud decorations
            VStack {
                HStack {
                    CloudShape()
                        .fill(Color.white)
                        .frame(width: 120, height: 70)
                        .offset(x: -30, y: 20)
                    
                    Spacer()
                    
                    CloudShape()
                        .fill(Color.white)
                        .frame(width: 150, height: 80)
                        .offset(x: 40, y: -10)
                }
                
                Spacer()
            }
            .ignoresSafeArea()
            
            // Main content
            VStack {
                // App header
                VStack(spacing: 16) {
                    Text("FindIt")
                        .font(.system(size: 38, weight: .bold, design: .rounded))
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                    
                    // Today's challenge
                    VStack(spacing: 10) {
                        Text("Today's Challenge")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 10)
                            
                            VStack(spacing: 16) {
                                Image(systemName: "car.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.blue)
                                
                                Text("Find a Red Car!")
                                    .font(.title3)
                                    .bold()
                                
                                HStack {
                                    Label {
                                        Text(formattedTime)
                                    } icon: {
                                        Image(systemName: "clock")
                                    }
                                    .font(.headline)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(
                                        Capsule()
                                            .fill(Color.blue.opacity(0.1))
                                    )
                                }
                                
                                Button {
                                    appState.selectedTab = .camera
                                } label: {
                                    Text("Take Photo")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 12)
                                        .padding(.horizontal, 24)
                                        .background(
                                            Capsule()
                                                .fill(Color.blue)
                                        )
                                }
                            }
                            .padding(24)
                        }
                        .padding(.horizontal)
                    }
                    
                    // Quick stats
                    HStack(spacing: 20) {
                        StatCardView(title: "Total Finds", value: "12")
                        StatCardView(title: "Best Time", value: "0:42")
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    // Recent activity
                    VStack(alignment: .leading) {
                        Text("Recent Activity")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(1...5, id: \.self) { _ in
                                    RecentActivityCard()
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            startTime = Date()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                elapsedTime = Date().timeIntervalSince(startTime)
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    var formattedTime: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct StatCardView: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.blue)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5)
        )
    }
}

struct RecentActivityCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 120, height: 120)
                
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .background(Circle().fill(Color.white))
                    .offset(x: -4, y: -4)
            }
            
            Text("Umbrella")
                .font(.subheadline)
                .fontWeight(.medium)
            
            Text("2:15")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

struct CloudShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width * 0.2, y: height * 0.6))
        path.addCurve(
            to: CGPoint(x: width * 0.5, y: height * 0.4),
            control1: CGPoint(x: width * 0.25, y: height * 0.4),
            control2: CGPoint(x: width * 0.35, y: height * 0.3)
        )
        path.addCurve(
            to: CGPoint(x: width * 0.8, y: height * 0.5),
            control1: CGPoint(x: width * 0.65, y: height * 0.3),
            control2: CGPoint(x: width * 0.75, y: height * 0.4)
        )
        path.addCurve(
            to: CGPoint(x: width * 0.9, y: height * 0.7),
            control1: CGPoint(x: width * 0.85, y: height * 0.55),
            control2: CGPoint(x: width * 0.9, y: height * 0.6)
        )
        path.addCurve(
            to: CGPoint(x: width * 0.7, y: height * 0.9),
            control1: CGPoint(x: width * 0.9, y: height * 0.8),
            control2: CGPoint(x: width * 0.8, y: height * 0.9)
        )
        path.addCurve(
            to: CGPoint(x: width * 0.3, y: height * 0.9),
            control1: CGPoint(x: width * 0.6, y: height * 0.9),
            control2: CGPoint(x: width * 0.4, y: height * 0.9)
        )
        path.addCurve(
            to: CGPoint(x: width * 0.1, y: height * 0.7),
            control1: CGPoint(x: width * 0.2, y: height * 0.9),
            control2: CGPoint(x: width * 0.1, y: height * 0.8)
        )
        path.addCurve(
            to: CGPoint(x: width * 0.2, y: height * 0.6),
            control1: CGPoint(x: width * 0.1, y: height * 0.65),
            control2: CGPoint(x: width * 0.15, y: height * 0.6)
        )
        
        path.closeSubpath()
        return path
    }
}

