//
//  AppState.swift
//  FindItApp
//
//  Created by _ on 4/23/25.
//
import SwiftUI

class AppState: ObservableObject {
    @Published var isSignedIn = false
    @Published var hasSeenItemReveal = false
    @Published var selectedTab: NavigationBar.Tab = .home
}
