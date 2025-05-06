//
//  MenuTabModel.swift
//  Bidify
//
//  Created by Hasara Dissanayake on 2025-04-04.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeContentView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            WishlistView()
                .tabItem {
                    Label("Wishlist", systemImage: "heart.fill")
                }

            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar.fill")
                }

            CompletedBidsView()
                .tabItem {
                    Label("Completed", systemImage: "checkmark.circle.fill")
                }

            UserProfileView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .accentColor(.teal) // Optional: to set the selected tab color
    }
}

