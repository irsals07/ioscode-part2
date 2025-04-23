//
//  SignupView.swift
//  FindItApp
//
//  Created by Aaron Siam on 4/20/25.
//

import SwiftUI

struct ItemRevealView: View {
    @EnvironmentObject private var appState: AppState
    @State private var scale = 0.5
    @State private var showInstructions = false
    
    var body: some View {
        ZStack {
            // Blue background
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.blue.opacity(0.1)]),
                          startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // Content
            VStack(spacing: 24) {
                // Title
                Text("Today's Item")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                // Item to find
                ZStack {
                    // Background
                    CloudShape()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.white, .white.opacity(0.8)]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(width: 220, height: 140)
                        .shadow(color: Color.black.opacity(0.1), radius: 10)
                    
                    // Icon
                    Image(systemName: "car.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .foregroundColor(.blue)
                        .scaleEffect(scale)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                                scale = 1.1
                            }
                        }
                }
                
                // Item name
                Text("Find a Red Car")
                    .font(.title)
                    .fontWeight(.bold)
                
                // Instructions
                VStack(alignment: .leading, spacing: 16) {
                    Text("**Objective:** Complete the challenge by finding and photographing a real-world object.")
                        .font(.headline)
                    
                    Text("**Instructions:**")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top, 8)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        InstructionRow(number: 1, text: "**Locate** the specified object.")
                        InstructionRow(number: 2, text: "**Take a photo** of the actual object.")
                        InstructionRow(number: 3, text: "**Share** your photo and the time.")
                        InstructionRow(number: 4, text: "**Compare** your completion times!")
                    }
                    .padding(.leading, 4)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 5)
                )
                .padding(.horizontal, 20)
                
                // Continue button
                Button {
                    withAnimation(.easeInOut) {
                        appState.hasSeenItemReveal = true
                    }
                } label: {
                    Text("Let's Go!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            Capsule()
                                .fill(Color.blue)
                                .shadow(color: Color.blue.opacity(0.3), radius: 5)
                        )
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct InstructionRow: View {
    var number: Int
    var text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text("\(number).")
                .font(.headline)
                .foregroundColor(.blue)
                .fontWeight(.bold)
            
            Text(.init(text))
                .font(.headline)
        }
    }
}
