//
//  SignupView.swift
//  FindItApp
//
//  Created by Aaron Siam on 4/20/25.
//

import SwiftUI

struct HomeView: View {
    @State private var startTime = Date()
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer?

    var body: some View {
        VStack(spacing: 20) {
            Text("Find This!")
                .font(.largeTitle)
                .bold()

            Image(systemName: "car.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)

            Text("Time Elapsed: \(formattedTime)")
                .font(.headline)

            NavigationLink("Open Camera", destination: CameraView())
            NavigationLink("Leaderboard", destination: LeaderboardView())
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
        return String(format: "%02dm %02ds", minutes, seconds)
    }
}
