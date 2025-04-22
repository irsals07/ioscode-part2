//
//  SignupView.swift
//  FindItApp
//
//  Created by Aaron Siam on 4/20/25.
//
import SwiftUI

struct SignupView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isSignedIn = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("FindIt")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)

                TextField("Username", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                Button("Sign Up") {
                    isSignedIn = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)

            }
            .padding()
            .navigationDestination(isPresented: $isSignedIn) {
                ItemRevealView()
            }
        }
    }
}

#Preview {
    SignupView()
}
