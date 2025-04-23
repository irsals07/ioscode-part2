//
//  ItemRevealOverlay.swift
//  FindItApp
//
//  Created by _ on 4/23/25.
//

import SwiftUI

struct ItemRevealOverlay: View {
    @Binding var isPresented: Bool
    @State private var scale = 0.5
    @State private var opacity = 0.0
    @State private var showInstructions = false
    
    var body: some View {
        ZStack {
            // Dimmed background
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    dismiss()
                }
            
            // Content card
            VStack(spacing: 0) {
                // Close button
                HStack {
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                
                // Content
                VStack(spacing: 24) {
                    // Title
                    Text("Today's Item")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    // Item to find
                    ZStack {
                        // Background
                        CloudShape()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [.blue.opacity(0.2), .blue.opacity(0.1)]),
                                startPoint: .top,
                                endPoint: .bottom
                            ))
                            .frame(width: 220, height: 140)
                        
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
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    // Instructions
                    if showInstructions {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("**Objective:** Complete the challenge by finding and photographing a real-world object.")
                                .font(.subheadline)
                            
                            Text("**Instructions:**")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                InstructionRow(number: 1, text: "**Locate** the specified object.")
                                InstructionRow(number: 2, text: "**Take a photo** of the actual object.")
                                InstructionRow(number: 3, text: "**Share** your photo and the time.")
                                InstructionRow(number: 4, text: "**Compare** your completion times!")
                            }
                            .padding(.leading, 4)
                        }
                        .padding(.horizontal)
                        .transition(.opacity)
                    }
                    
                    // Buttons
                    VStack(spacing: 16) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Let's Go!")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    Capsule()
                                        .fill(Color.blue)
                                )
                        }
                        
                        Button {
                            withAnimation(.easeInOut) {
                                showInstructions.toggle()
                            }
                        } label: {
                            Text(showInstructions ? "Hide Instructions" : "How to Play")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.top, 16)
                }
                .padding()
            }
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 20)
            )
            .padding(24)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.3)) {
                    opacity = 1.0
                }
            }
        }
    }
    
    func dismiss() {
        withAnimation(.easeInOut(duration: 0.2)) {
            opacity = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            isPresented = false
        }
    }
}
