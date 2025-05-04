//
//  HomeContentView.swift
//  Bidify
//
//  Created by Hasara Dissanayake on 2025-04-04.
//
import SwiftUI

// MARK: - Color Extensions
extension Color {
    static let primaryColor = Color(hex: "#5F99AE")
    static let accentColor = Color(hex: "#336D82")
    static let backgroundColor = Color(hex: "#F5ECE0")
}

// MARK: - Hex Color Support
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Dashboard View
struct HomeContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(0)

            Text("My Cart")
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("My Cart")
                }
                .tag(1)

            Text("Pending Bids")
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("Pending")
                }
                .tag(2)

            Text("Completed Bids")
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Completed")
                }
                .tag(3)

            Text("Settings")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(4)
        }
        .accentColor(.primaryColor)
    }
}

// MARK: - Home View
struct HomeView: View {
    @State private var bidItems: [BidItem] = [
        BidItem(
            id: 1,
            name: "iPhone 14",
            quantity: 1,
            highestBid: 1200,
            imageName: "iphone",
            description: "Latest iPhone model with advanced features.",
            condition: "Brand New",
            addedDate: Date().addingTimeInterval(-86400),
            lastBidTime: Date().addingTimeInterval(-3600)
        ),
        BidItem(
            id: 2,
            name: "MacBook Pro",
            quantity: 2,
            highestBid: 2200,
            imageName: "laptopcomputer",
            description: "Refurbished 16-inch MacBook Pro with M2 chip.",
            condition: "Refurbished",
            addedDate: Date().addingTimeInterval(-172800),
            lastBidTime: Date().addingTimeInterval(-7200)
        )
    ]

    var body: some View {
        VStack(spacing: 0) {
            // AppBar
            HStack {
                Text("Bidify")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                Spacer()
                Button(action: {
                    // Navigate to cart
                }) {
                    Image(systemName: "cart")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.primaryColor)
                }
            }
            .padding()
            .background(Color.white)
            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)

            // Item List
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(bidItems) { item in
                        BidItemCard(item: item)
                    }
                }
                .padding()
            }

            Spacer()
        }
        .background(Color.backgroundColor.ignoresSafeArea())
        .navigationBarHidden(true)
    }
}

// MARK: - Bid Item Card
struct BidItemCard: View {
    let item: BidItem
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.trailing, 8)
                    .foregroundColor(.primaryColor)
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name)
                        .font(.headline)
                        .foregroundColor(.accentColor)
                    Text("Qty: \(item.quantity)")
                        .font(.subheadline)
                    Text("Highest Bid: $\(item.highestBid, specifier: "%.2f")")
                        .font(.subheadline)
                }
                Spacer()
            }

            Text(item.description)
                .font(.body)
                .foregroundColor(.secondary)

            Text("Condition: \(item.condition)")
                .font(.subheadline)
                .foregroundColor(.accentColor)

            HStack {
                Text("Added: \(dateFormatter.string(from: item.addedDate))")
                Spacer()
                Text("Last Bid: \(dateFormatter.string(from: item.lastBidTime))")
            }
            .font(.footnote)
            .foregroundColor(.gray)

            Button(action: {
                // View item details
            }) {
                Text("View Item")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.primaryColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.15), radius: 5, x: 0, y: 3)
    }
}

// MARK: - Model
struct BidItem: Identifiable {
    let id: Int
    let name: String
    let quantity: Int
    let highestBid: Double
    let imageName: String
    let description: String
    let condition: String
    let addedDate: Date
    let lastBidTime: Date
}

// MARK: - Preview
struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
    }
}
