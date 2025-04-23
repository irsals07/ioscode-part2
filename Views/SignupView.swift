//
//  SignupView.swift
//  FindItApp
//
//  Created by Aaron Siam on 4/20/25.
//
import SwiftUI

struct SignupView: View {
    @EnvironmentObject private var appState: AppState
    @State private var username = ""
    @State private var password = ""
    @State private var isAnimating = false
    @State private var cloudOffset: CGFloat = -100
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white]),
                          startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // Animated clouds
            VStack {
                CloudShape()
                    .fill(Color.white.opacity(0.8))
                    .frame(width: 200, height: 100)
                    .offset(x: cloudOffset)
                    .animation(
                        Animation.easeInOut(duration: 8)
                            .repeatForever(autoreverses: true),
                        value: cloudOffset
                    )
                    .onAppear {
                        cloudOffset = 100
                    }
                
                Spacer()
            }
            .padding(.top, 50)
            
            VStack(spacing: 30) {
                // Logo/App title
                VStack(spacing: 10) {
                    CloudShape()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.blue, .blue.opacity(0.6)]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(width: 100, height: 60)
                        .scaleEffect(isAnimating ? 1.05 : 1.0)
                        .animation(
                            Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true),
                            value: isAnimating
                        )
                        .overlay(
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                                .offset(y: 5)
                        )
                    
                    Text("FindIt")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.blue)
                }
                .padding(.top, 60)
                
                // Tag line
                Text("Find. Capture. Share.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                
                // Input fields
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.blue)
                        
                        TextField("Username", text: $username)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 2)
                    )
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.blue)
                        
                        SecureField("Password", text: $password)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 2)
                    )
                }
                .padding(.horizontal, 24)
                
                // Sign up button
                Button {
                    withAnimation(.spring()) {
                        appState.isSignedIn = true
                    }
                } label: {
                    Text("Sign Up")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [.blue, .blue.opacity(0.8)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                                .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 3)
                        )
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                
                // Already have an account
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                    
                    Button {
                        // Handle sign in action
                        withAnimation(.spring()) {
                            appState.isSignedIn = true
                        }
                    } label: {
                        Text("Sign In")
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                }
                .font(.subheadline)
                .padding(.top, 20)
                
                Spacer()
            }
            .padding()
        }
        .onAppear {
            isAnimating = true
        }
    }
}
