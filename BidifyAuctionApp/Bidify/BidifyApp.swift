//
//  BidifyApp.swift
//  Bidify
//
//  Created by Hasara Dissanayake on 2025-04-04.
//

import SwiftUI

@main
struct BidifyApp: App {
    @StateObject var bidManager = BidManager()
    @AppStorage("isLoggedIn") private var isLoggedIn = false  // ✅ Persistent login state

    init() {
        // Load all persisted data (bids, cart, wishlist) at startup
        bidManager.loadAll()
    }

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainTabView()
                    .environmentObject(bidManager)
            } else {
                LoginInterface(isLoggedIn: $isLoggedIn)
                    .environmentObject(bidManager)
            }
        }
    }
}
