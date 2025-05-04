//
//  DashboardView.swift
//  Bidify
//
//  Created by Naween Weerasinghe on 2025-05-01.
//

import SwiftUI
import Charts

struct DashboardView: View {
    let totalBids = 150
    let successRate = 85.0
    let totalSpend: Double = 12000.0
    let averageSpend: Double = 80.0

    let bidBreakdown: [BidResult] = [
        BidResult(type: "Won", value: 60),
        BidResult(type: "Lost", value: 40),
        BidResult(type: "Canceled", value: 30)
    ]

    let bidsOverTime: [BidsByMonth] = [
        BidsByMonth(month: "Jan", count: 10),
        BidsByMonth(month: "Feb", count: 20),
        BidsByMonth(month: "Mar", count: 15),
        BidsByMonth(month: "Apr", count: 25)
    ]

    let categories: [AuctionCategory] = [
        AuctionCategory(name: "Electronics", count: 40),
        AuctionCategory(name: "Furniture", count: 30),
        AuctionCategory(name: "Clothing", count: 20)
    ]

    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Dashboard title - centered
                    HStack {
                        Spacer()
                        Text("Dashboard")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding(.top)

                    // Stats Grid
                    LazyVGrid(columns: columns, spacing: 16) {
                        StatCard(title: "Total Bids", value: "\(totalBids)")
                        StatCard(title: "Success Rate", value: "\(Int(successRate))%")
                        StatCard(title: "Total Spend", value: "$\(Int(totalSpend))")
                        StatCard(title: "Avg Spend", value: "$\(Int(averageSpend))")
                    }

                    // Pie Chart
                    Text("Bid Breakdown")
                        .font(.headline)

                    Chart {
                        ForEach(bidBreakdown) { result in
                            SectorMark(
                                angle: .value("Amount", result.value),
                                innerRadius: .ratio(0.5),
                                angularInset: 2.0
                            )
                            .foregroundStyle(by: .value("Type", result.type))
                        }
                    }
                    .frame(height: 200)

                    // Line Chart
                    Text("Bids Over Time")
                        .font(.headline)

                    Chart(bidsOverTime) {
                        LineMark(
                            x: .value("Month", $0.month),
                            y: .value("Bids", $0.count)
                        )
                    }
                    .frame(height: 200)

                    // Bar Chart
                    Text("Most Auctioned Categories")
                        .font(.headline)

                    Chart(categories) {
                        BarMark(
                            x: .value("Category", $0.name),
                            y: .value("Count", $0.count)
                        )
                        .foregroundStyle(.teal)
                    }
                    .frame(height: 200)
                }
                .padding()
            }

            Divider()

            // Inline Footer Section
            HStack {
                Button(action: {
                    // Navigate to Home
                }) {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                            .font(.footnote)
                    }
                }
                Spacer()
                Button(action: {
                    // Navigate to Dashboard
                }) {
                    VStack {
                        Image(systemName: "chart.bar.fill")
                        Text("Dashboard")
                            .font(.footnote)
                    }
                }
                Spacer()
                Button(action: {
                    // Navigate to Wishlist
                }) {
                    VStack {
                        Image(systemName: "heart.fill")
                        Text("Wishlist")
                            .font(.footnote)
                    }
                }
                Spacer()
                Button(action: {
                    // Navigate to Completed
                }) {
                    VStack {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Completed")
                            .font(.footnote)
                    }
                }
                Spacer()
                Button(action: {
                    // Navigate to Settings
                }) {
                    VStack {
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                            .font(.footnote)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .foregroundColor(.teal)
        }
    }
}

// MARK: - Stat Card View
struct StatCard: View {
    var title: String
    var value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Text(value)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
        }
        .padding()
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(Color.teal)
        .cornerRadius(10)
    }
}

// MARK: - Models
struct BidResult: Identifiable {
    var id = UUID()
    var type: String
    var value: Double
}

struct BidsByMonth: Identifiable {
    var id = UUID()
    var month: String
    var count: Int
}

struct AuctionCategory: Identifiable {
    var id = UUID()
    var name: String
    var count: Int
}

// MARK: - Preview
#Preview {
    DashboardView()
}
