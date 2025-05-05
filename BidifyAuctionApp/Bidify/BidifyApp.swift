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

    var body: some Scene {
        WindowGroup {
            LoginInterface()
                .environmentObject(bidManager) // ✅ Inject BidManager
        }
    }
}
