//
//  SignupView.swift
//  FindItApp
//
//  Created by Aaron Siam on 4/20/25.
//

import SwiftUI

struct ItemRevealView: View {
    @State private var scale = 0.5

    var body: some View {
        VStack {
            Text("Today's Item")
                .font(.title)
                .bold()
                .padding()

            Image(systemName: "car.fill") // Replace with dynamic item later
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(.blue)
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                        scale = 1.2
                    }
                }

            NavigationLink("Continue", destination: HomeView())
                .padding()
        }
    }
}
