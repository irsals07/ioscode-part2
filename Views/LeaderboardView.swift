//
//  SignupView.swift
//  FindItApp
//
//  Created by Aaron Siam on 4/20/25.
//

import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        List {
            Text("1. aaron - 1m 23s")
            Text("2. jane - 2m 10s")
            Text("3. bob - 5m 02s")
        }
        .navigationTitle("Leaderboard")
    }
}
